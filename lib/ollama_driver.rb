require 'base64'
require 'colorator'
require 'json'
require 'net/http'
require 'ollama-ai'

class OllamaDriver
  def self.help(msg)
    puts "#{msg}\n".red if msg
    progname = File.basename $PROGRAM_NAME
    msg = <<~END_MSG
      #{progname} - Use an Ollama model to summarize a document
      Usage: #{progname} FILENAME
    END_MSG
    puts msg
    exit 1
  end

  # @param temperature control creativity
  def initialize(
    address:     'http://localhost:11434',
    model:       'samantha-mistral',
    temperature: 0.8,
    timeout:     60
  )
    @address = address
    @model = model
    @temperature = temperature
    @timeout = timeout
  end

  # You need to choose a model that supports images, like LLaVA or bakllava
  def describe_image(image_filename)
    @client = Ollama.new(
      credentials: { address: @address },
      options:     {
        server_sent_events: true,
        temperature:        @temperature,
        connection:         { request: { timeout: @timeout, read_timeout: @timeout } },
      }
    )
    result = @client.generate(
      {
        model:  @model,
        prompt: 'Please describe this image.',
        images: [Base64.strict_encode64(File.read(image_filename))],
      }
    )
    puts result.map { |x| x['response'] }.join
  end

  def summarize(filename)
    @client = Ollama.new(
      credentials: { address: @address },
      options:     {
        server_sent_events: false,
        temperature:        @temperature,
        connection:         { request: { timeout: @timeout, read_timeout: @timeout } },
      }
    )
    result = @client.generate(
      {
        model:  @model,
        prompt: query(File.read(filename)),
        stream: false,
      }
    )
    puts result.first['response']
  end

  def query(text)
    <<~END_MSG
      Write a summary of the following text delimited by triple backticks.
      Return your response which covers the key points of the text.
      ```#{text}```
      SUMMARY:
    END_MSG
  end
end
