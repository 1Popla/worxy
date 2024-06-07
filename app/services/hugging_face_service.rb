require 'httparty'

class HuggingFaceService
  include HTTParty
  base_uri 'https://api-inference.huggingface.co/models'

  def initialize(model = 'EleutherAI/gpt-neo-2.7B')
    @model = model
    @headers = {
      'Authorization' => "Bearer #{ENV['HUGGING_FACE_API_KEY']}",
      'Content-Type': 'application/json'
    }
  end

  def generate_text(prompt, max_length = 300)
    options = {
      headers: @headers,
      body: {
        inputs: prompt,
        parameters: {
          max_length: max_length
        }
      }.to_json
    }

    response = self.class.post("/#{@model}", options)
    Rails.logger.info("Response: #{response.body}")

    if response.success?
      response_body = response.parsed_response
      if response_body.is_a?(Array) && response_body[0].is_a?(Hash) && response_body[0]['generated_text']
        return clean_generated_text(response_body[0]['generated_text'])
      else
        return "Error: Unexpected response format"
      end
    else
      "Error: #{response.code} #{response.message}"
    end
  rescue => e
    Rails.logger.error("HuggingFaceService error: #{e.message}")
    "Error generating description"
  end

  private

  def clean_generated_text(text)
    # Ensure the generated text is properly cleaned
    # Remove the prompt if it appears in the response
    prompt_index = text.index("User details:")
    return text if prompt_index.nil?

    generated_start = text[(prompt_index + "User details:".length)..].strip
    generated_start.split("\n").reject { |line| line.include?("User details:") || line.include?("Please create a unique and engaging description.") }.join("\n").strip
  end
end
