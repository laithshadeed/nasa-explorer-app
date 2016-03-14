require 'spec_helper'

Plateau = NasaExplorerApp::Plateau unless defined?(Plateau)
Grid    = NasaExplorerApp::Grid unless defined?(Grid)

describe Plateau do
  it 'can be instantiated with max_x & max_y' do
    p = Plateau.new(max_x: 2, max_y: 2)
    expect(p).to be_kind_of(Plateau)
    expect(p.max_x).to eq(2)
    expect(p.max_y).to eq(2)
  end

  it 'will raise ArgumentError if max_x or max_y more than maximum' do
    # At the moments, the max values are hardcoded in Plateau class to
    # MAX_X = 64, MAX_Y = 64

    args = { max_x: 100, max_y: 100 }
    expect { Plateau.new(args) }.to raise_error(ArgumentError)

    args = { max_x: 5, max_y: 100 }
    expect { Plateau.new(args) }.to raise_error(ArgumentError)

    args = { max_x: 100, max_y: 5 }
    expect { Plateau.new(args) }.to raise_error(ArgumentError)
  end

  it 'can get a grid' do
    p = Plateau.new(max_x: 2, max_y: 2)
    g = p.get_or_create_grid!(x: 0, y: 1)
    expect(g).to be_kind_of(Grid)
    expect(g.x).to eq(0)
    expect(g.y).to eq(1)
  end

  it 'can not get a grid outside the plateau' do
    p = Plateau.new(max_x: 2, max_y: 2)
    expect(p.get_or_create_grid!(x: 5, y: 5)).to eq(nil)
    expect(p.get_or_create_grid!(x: -2, y: -1)).to eq(nil)
    expect(p.get_or_create_grid!(x: 100, y: 100)).to eq(nil)
  end
end
