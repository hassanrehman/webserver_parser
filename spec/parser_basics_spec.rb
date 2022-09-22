# Test cases for faulty input in command line arguments
RSpec.describe Parser do
  subject { described_class.new(arguments).visits }

  let(:arguments) { [] }
  let(:input_file) do
    Tempfile.new('csv').tap do |f|
      f.close
    end
  end

  after { input_file.unlink }

  context 'No arguments' do
    it('runs') { expect(subject).to eq([]) }
  end

  context 'No arguments' do
    it('runs') { expect(subject).to eq([]) }
  end

  context 'File missing' do
    let(:arguments) { [SecureRandom.hex] }
    it('runs') { expect(subject).to eq([]) }
  end

  context 'Empty File' do
    it('runs') { expect(subject).to eq([]) }
  end
end
