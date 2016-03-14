require 'spec_helper'

Plateau = NasaExplorerApp::Plateau unless defined?(Plateau)
Grid    = NasaExplorerApp::Grid unless defined?(Grid)

describe NasaExplorerApp::Grid do
  plateau = Plateau.new(max_x: 3, max_y: 3)
  build_params = { x: 1, y: 1, plateau: plateau }

  it 'can be instantiated' do
    grid = Grid.new(build_params)
    expect(grid.class).to eq(Grid)
    expect(grid.x).to eq(1)
    expect(grid.y).to eq(1)
  end

  it 'raise error if plateau is not a Plateau object' do
    build_params[:plateau] = Object.new
    expect { Grid.new(build_params) }.to raise_error(ArgumentError)
    build_params[:plateau] = plateau
  end

  it 'can cast x,y as integer with string type to integer type' do
    build_params[:x] = '1'
    build_params[:y] = '1'
    grid = Grid.new(build_params)
    expect(grid.x).to eq(1)
    expect(grid.y).to eq(1)
  end

  it 'raise ArgumentError if x,y if unparsable intger' do
    build_params[:x] = '1x'
    build_params[:y] = '1y'
    expect { Grid.new(build_params) }.to raise_error(ArgumentError)
  end
  it 'has neighbours of grids' do
    n = plateau.get_or_create_grid!(x: 1, y: 1).neighbours
    expect(n).to be_kind_of(Hash)
    expect(n['N'].object_id).to \
      eq(plateau.get_or_create_grid!(x: 1, y: 2).object_id)
    expect(n['S'].object_id).to \
      eq(plateau.get_or_create_grid!(x: 1, y: 0).object_id)
    expect(n['W'].object_id).to \
      eq(plateau.get_or_create_grid!(x: 0, y: 1).object_id)
    expect(n['E'].object_id).to \
      eq(plateau.get_or_create_grid!(x: 2, y: 1).object_id)
  end

  it 'has two neighbours if in the corner of the plateau' do
    n = plateau.get_or_create_grid!(x: 3, y: 3).neighbours
    expect(n).to be_kind_of(Hash)
    expect(n['N']).to eq(nil)
    expect(n['S'].object_id).to \
      eq(plateau.get_or_create_grid!(x: 3, y: 2).object_id)
    expect(n['W'].object_id).to \
      eq(plateau.get_or_create_grid!(x: 2, y: 3).object_id)
    expect(n['E']).to eq(nil)
  end

  it 'has three neighbours if at the edge of the plateau' do
    n = plateau.get_or_create_grid!(x: 1, y: 0).neighbours
    expect(n).to be_kind_of(Hash)
    expect(n['S']).to eq(nil)
    expect(n['N'].object_id).to \
      eq(plateau.get_or_create_grid!(x: 1, y: 1).object_id)
    expect(n['W'].object_id).to \
      eq(plateau.get_or_create_grid!(x: 0, y: 0).object_id)
    expect(n['E'].object_id).to \
      eq(plateau.get_or_create_grid!(x: 2, y: 0).object_id)
  end
end
