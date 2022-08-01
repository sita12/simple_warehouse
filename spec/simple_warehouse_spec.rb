require './app/simple_warehouse'

describe SimpleWarehouse do
    before(:each) do
        @warehouse = SimpleWarehouse.new
    end
    describe '.initialize_warehouse' do
        it 'should set width and height of warehouse' do
            @warehouse.initialize_warehouse(12, 8)
            @warehouse.width.should == 12
            @warehouse.height.should == 8
        end
    end
end