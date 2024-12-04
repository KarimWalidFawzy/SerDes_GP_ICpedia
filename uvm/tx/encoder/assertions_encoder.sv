import enums ::*;
module assertions_encoder (encoder_if.DUT _if);
    
    //*****************************//
    // : Write Assertions Here //
    //*****************************//

    int x ;
    int i; // declaring Rd 


initial begin
    x=-1;
    forever begin
        @(posedge _if.BitCLK_10)
        if(_if.Reset) begin
        for (i =0 ;i<10 ;i++ ) begin
            if(_if.TxParallel_10[i])
            x=x+1;
            else x=x-1;
         end 
        end
    end
end
    



        // Property to check for no 5 consecutive 1s or 0s in TxParallel_10
        property five_consecutive_bits;
            @(posedge _if.BitCLK_10 )  disable iff (!_if.Reset || (_if.TxParallel_8 == S_28_1 &&_if.TxDataK) || (_if.TxParallel_8 == S_28_5 &&_if.TxDataK) || (_if.TxParallel_8== S_28_7 &&_if.TxDataK) )       // Disable the property during reset and during k28.1,k28.5,k28.7
            !(_if.TxParallel_10[9:5] == 5'b11111 || _if.TxParallel_10[9:5] == 5'b00000 ||
              _if.TxParallel_10[8:4] == 5'b11111 || _if.TxParallel_10[8:4] == 5'b00000 ||  
              _if.TxParallel_10[7:3] == 5'b11111 || _if.TxParallel_10[7:3] == 5'b00000 || 
              _if.TxParallel_10[6:2] == 5'b11111 || _if.TxParallel_10[6:2] == 5'b00000 || 
              _if.TxParallel_10[5:1] == 5'b11111 || _if.TxParallel_10[5:1] == 5'b00000 ||
              _if.TxParallel_10[4:0] == 5'b11111 || _if.TxParallel_10[4:0] == 5'b00000);   
        endproperty
    property disparity ;
        @(posedge _if.BitCLK_10 ) disable iff(!_if.Reset)
        !( x>2 || x<-2
        );
    endproperty
        // Assert the property
        assert_five_consecutive_bits: assert property (five_consecutive_bits)
            else $error("5 consecutive 1s or 0s detected in TxParallel_10: %b", _if.TxParallel_10);
            
        assert_disparity: assert property (disparity)
            else $error("disparity error");

        assert_five_consecutive_bits_cover: cover property (five_consecutive_bits);
        assert_disparity_cover: cover property (disparity);
    

endmodule