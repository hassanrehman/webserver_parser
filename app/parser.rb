class Parser
  def initialize(arguments)
    @input_file = arguments[0]
  end

  def run
    puts ordered_paths.map { |p| p.join(" ") }
  end

  def ordered_paths
    File.readlines(@input_file)
      .map{|l| l.split(" ") } # separate each path
      .group_by(&:first).transform_values!(&:count) # Get the hash with counts
      .to_a.sort_by { |k, v| v }.reverse # Largest first
  end
end
