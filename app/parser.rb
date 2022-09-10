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
  def visits
    return [] if @input_file.nil? || !File.exist?(@input_file)

    File.readlines(@input_file)
      .select { |l| l.start_with?("/") }
      .map { |l| l.split(" ") } # separate each path
      .group_by(&:first).transform_values!(&:count) # Get the hash with counts
      .to_a.sort_by { |k, v| [-1*v, k] } # Largest first
  end

  def unique_views
    return [] if @input_file.nil? || !File.exist?(@input_file)

    File.readlines(@input_file)
      .select { |l| l.start_with?("/") }
      .group_by { |l| l }
      .transform_values!(&:count) # Get the hash with counts
      .to_a.sort_by { |k, v| [-1*v, k] } # Largest first
  end
end
