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
end