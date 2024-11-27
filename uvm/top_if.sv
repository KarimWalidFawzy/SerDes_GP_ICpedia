
import enums::*;
interface top_if (BitCLK, BitCLK_10_Tx, BitCLK_10_Rx);
    input BitCLK, BitCLK_10_Tx, BitCLK_10_Rx;
    bit Reset;
    bit TxDataK, RxDataK;
    data_symbol TxParallel_8, RxParallel_8;
endinterface