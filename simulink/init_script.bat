@set /p vivado_path= Absolute path to Vivado 2019 on your desk:

@echo:vivado_path = '%vivado_path%';> run_cosim.m
@echo:>> run_cosim.m
@echo:hdlverifier_compile(vivado_path)>> run_cosim.m
@echo:hdlverifier_gendll_digital_top(vivado_path)>> run_cosim.m