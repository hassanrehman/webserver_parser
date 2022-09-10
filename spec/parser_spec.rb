RSpec.describe Parser do
  subject { described_class.new(arguments).ordered_paths }

  # Setting base as happy case, one file as argument, no lines in it
  let(:arguments) { [input_file.path] }
  let(:input_file) do
    Tempfile.new('csv').tap do |f|
      f.print lines.join("\n")
    ensure
      f.close
    end
  end
  let(:lines) { [] }

  after { input_file.unlink }

  context 'No arguments' do
    let(:arguments) { [] }
    it('runs') { expect(subject).to eq([]) }
  end

  context 'File missing' do
    let(:arguments) { [SecureRandom.hex] }
    it('runs') { expect(subject).to eq([]) }
  end

  context 'Empty File' do
    it('runs') { expect(subject).to eq([]) }
  end

  context 'Ordered lines, no repetition' do
    let(:lines) do
      [
        "/home 1.1.1.1",
        "/index 1.1.1.1",
        "/show 1.1.1.1",
      ]
    end

    it('runs') do
      expect(subject).to eq(
        [
          ["/home", 1],
          ["/index", 1],
          ["/show", 1],
        ]
      )
    end
  end
end
