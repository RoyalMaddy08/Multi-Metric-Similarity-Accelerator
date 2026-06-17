# BRAM-Based-KNN-Accelerator

KNN-FPGA/
│
├── README.md
│
├── rtl/
│   ├── knn_bram_top.v
│   ├── bram_distance_top.v
│   ├── euclidean.v
│   ├── min_finder_pipe_16.v
│   └── unpacker.v
│
├── tb/
│   └── tb_knn_bram_top.v
│
├── memory/
│   ├── dataset.mem
│   └── dataset.mif
│
├── constraints/
│   └── top.xdc
│
├── docs/
│   ├── architecture.png
│   ├── rtl_schematic.png
│   ├── timing_report.png
│   ├── waveform.png
│   └── device_view.png
│
└── vivado/
    └── create_project.tcl
