class Parser
  def initialize(arguments)
    @input_file = arguments[0]
  end

  def run
    puts ordered_paths.map { |p| p.join(" ") }
  end

  # Reads the @input_file and returns an ordered array with:
  #   ["path", count]
  #
  def ordered_paths
    return [] if @input_file.nil? || !File.exist?(@input_file)

    File.readlines(@input_file)
      .map{|l| l.split(" ") } # separate each path
      .group_by(&:first).transform_values!(&:count) # Get the hash with counts
      .to_a.sort_by { |k, v| [-1*v, k] } # Largest first
  end
end
