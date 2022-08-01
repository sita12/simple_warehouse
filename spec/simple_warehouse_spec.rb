require './app/simple_warehouse'

describe SimpleWarehouse do
    before(:each) do
        @warehouse = SimpleWarehouse.new
        @warehouse.width = 12
        @warehouse.height = 8
        @warehouse.data = {}
    end
    describe '.initialize_warehouse' do
        it 'should set width and height of warehouse' do
            @warehouse.initialize_warehouse(12, 8)
            @warehouse.width.should == 12
            @warehouse.height.should == 8
        end
    end
    describe '.coordinates' do
        it 'should give bottom left coordinate' do
            @warehouse.coordinates(3, 2, 4, 3).should == [3, 1]
        end
        it 'should give top left coordinate' do
            @warehouse.coordinates(8, 4, 2, 4).should == [7, 2]
        end
    end
    describe '.store_value' do
        it 'should store crate' do
            size = @warehouse.data.size
            @warehouse.store_value(3, 2, 4, 3, "P")
            @warehouse.data.size.should == size + 1
        end
        it 'should not store crate' do
            size = @warehouse.data.size
            @warehouse.store_value(15, 3, 2, 4, "K")
            @warehouse.data.size.should == size
        end
    end
    describe '.locate' do
        it 'should not locate non existing crate' do
            @warehouse.store_value(3, 2, 4, 3, "P")
            expect do
                @warehouse.locate("Q")
            end.to output(/Either Warehouse is not initialized or Crate Doesn't exist in the warehouse/).to_stdout
        end
    end
    describe '.remove' do
        it 'should remove crate' do
            @warehouse.store_value(3, 2, 4, 3, "P")
            size = @warehouse.data.size
            @warehouse.remove(3, 2)
            @warehouse.data.size.should == size - 1
        end
        it 'should not remove crate' do
            size = @warehouse.data.size
            @warehouse.remove(5, 6)
            @warehouse.data.size.should == size
        end
    end
end