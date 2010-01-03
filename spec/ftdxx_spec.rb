require "ftd2xx"

describe Ftd2xx do
  it "sets vendor and product id" do
    Ftd2xx.ft_set_vidpid(0x1781,0x0c30).should == Ftd2xx::FT_OK
  end
end