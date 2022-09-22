# Reads the file given in the command line (if valid)
# And allows the caller to stream only the valid lines
class FileReader
  def initialize(args)
    @args = args
  end

  # given the block, yield page and ip address to make decisions
  def call
    return if input_file.nil?

    File.foreach(input_file) do |line|
      page, ip, _ = (line || "").split(" ")

      if page && /\A\// =~ page && ip && /\A(\d+\.){3}\d+\z/ =~ ip
        yield(page, ip, line)
      end
    end
  end

  def input_file
    @args[0] if @args[0] && File.exist?(@args[0])
  end
end
