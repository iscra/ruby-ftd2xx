require File.join(File.dirname(__FILE__),"..","ext","ftd2xx")

#preconditions: tellstick inserted in usbport. libftd2xx.dylib installed in /usr/local/lib
#               ftd2xx.h and WinTypes.h in /usr/local/include
#               run ./swigit.sh located in ../lib, this generates ftd2xx.bundle

describe Ftd2xx do
  context "One tellstick currently attached to an usbport" do

    it "sets vendor and product id" do
      Ftd2xx.ft_set_vidpid(0x1781,0x0c30).should == Ftd2xx::FT_OK
    end

    context "vendor and product id has been set" do
      before(:each) do
        Ftd2xx.ft_set_vidpid(0x1781,0x0c30)
        @handle = nil
      end
      after(:each) do
        Ftd2xx.ft_close(@handle)
      end
      
      it "creates a device info list, returns number of devices" do
        Ftd2xx.create_device_info_list.should == 1
      end

      it "opens the device and returns a handle" do
        device_index = Ftd2xx.create_device_info_list - 1
        @handle = Ftd2xx.open(device_index)
        @handle.should_not == nil
      end

      context "device index larger than number of devices" do
        it "it does not open a device and the handle returned is nil" do
          device_index = Ftd2xx.create_device_info_list
          @handle = Ftd2xx.open(device_index)
          @handle.should == nil
        end
      end

      it "closes the usbport for a given handle" do
        device_index = Ftd2xx.create_device_info_list - 1
        handle = Ftd2xx.open(device_index)
        Ftd2xx.ft_close(handle).should == Ftd2xx::FT_OK
      end
      
      it "reads the eeprom data" do
        data = Ftd2xx::FtProgramData.new
        data.Signature1 = 0x00000000 
        data.Signature2 = 0xffffffff 
        data.Version = 0x00000002
        data.Manufacturer = "" 
        data.ManufacturerId = "" 
        data.Description = "" 
        data.SerialNumber = "" 

        device_index = Ftd2xx.create_device_info_list - 1
        @handle = Ftd2xx.open(device_index)
        Ftd2xx.ft_ee_read(@handle,data).should == Ftd2xx::FT_OK
        data.Manufacturer.should == "Telldus" 
        data.ManufacturerId.should == "A6" 
        data.Description.should == "TellStick" 
        data.ProductId.should == 3120 #0x0c30
        data.VendorId.should == 6017 #0x1781
      end
            
      it "writes to an open usbport" do
        device_index = Ftd2xx.create_device_info_list - 1
        @handle = Ftd2xx.open(device_index)
        Ftd2xx.ft_set_baud_rate(@handle,4800).should == Ftd2xx::FT_OK
        Ftd2xx.ft_set_timeouts(@handle,5000,0).should == Ftd2xx::FT_OK
        Ftd2xx.write(@handle,"S+").should == 8 #utf8 * 2 = 4 * 2 bytes
        reply = "    "
        Ftd2xx.read(@handle,reply).should == 4
        reply.should == "+S\r\n"
      end
    end
  end  
end