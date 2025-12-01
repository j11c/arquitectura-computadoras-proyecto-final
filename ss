[33mcommit 8aad2a1f674e98587b8b5adc7057ea8d54b3cb6e[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mfeature/alu_flags[m[33m, [m[1;31morigin/main[m[33m, [m[1;31morigin/HEAD[m[33m, [m[1;32mmain[m[33m)[m
Merge: b66a1d4 0ad3821
Author: Joshua Israel Ibarra Cárdenas <65472861+j11c@users.noreply.github.com>
Date:   Sun Nov 30 20:41:12 2025 -0800

    Merge pull request #2 from j11c/feature/alu_flags
    
    deature / NOP operation

[33mcommit b66a1d476c0bb55a5385a0e7a456d32e63c5b08f[m
Author: j11c <gbjiic@gmail.com>
Date:   Sun Nov 30 20:37:25 2025 -0800

    Defined number of control signals and indexes of each according to control signal document.

[33mcommit 0ad3821d5d44ef4d65e27b8aa1041629e48e0c51[m[33m ([m[1;31morigin/feature/alu_flags[m[33m)[m
Author: LuisAdrian5519 <luisadrian.cabrera5519@gmail.com>
Date:   Sun Nov 30 19:54:27 2025 -0800

    NOP

[33mcommit 5d254bddbea53b12c95924b718e91465cd35169f[m
Merge: 96e7021 c4fcc74
Author: Joshua Israel Ibarra Cárdenas <65472861+j11c@users.noreply.github.com>
Date:   Sun Nov 30 19:14:28 2025 -0800

    Merge pull request #1 from j11c/feature/alu_flags
    
    Feature/alu flags implementarion

[33mcommit c4fcc74013f28bcbee764aefc931a64b91e1c660[m
Author: LuisAdrian5519 <luisadrian.cabrera5519@gmail.com>
Date:   Sun Nov 30 18:45:00 2025 -0800

    Actualización de flags NFZF Fix1

[33mcommit d3cf56814f1affc4a1421f126f8320d1615d70a9[m
Author: LuisAdrian5519 <luisadrian.cabrera5519@gmail.com>
Date:   Sun Nov 30 18:40:50 2025 -0800

    Actualización de flags NFZF en todas las operaciones de ALU

[33mcommit 96e7021f356a704dee512e60fcf1922cd020ff9f[m
Author: j11c <gbjiic@gmail.com>
Date:   Sun Nov 30 15:11:24 2025 -0800

    MMAR_SEL signal made combinational based on Instruction format.

[33mcommit f75ccb6a6ce2f2abddcce0b1586c747fb8c9d813[m
Author: j11c <gbjiic@gmail.com>
Date:   Sun Nov 30 14:56:44 2025 -0800

    MMBR select signal defined to depend on instruction format. Added auxiliary signal 'externalInput' for MMBR signal (bit 1) that sets to '1' when COOP is IN.

[33mcommit 69849b08076f1d476d5cb2139774de3684d6fe6f[m
Author: j11c <gbjiic@gmail.com>
Date:   Sun Nov 30 14:30:31 2025 -0800

    MUX0 inputs: MBR output on A4-A7. Redundancy to support Immediate input and memory data input without IR_out(1:0) value impacting MUX selection.

[33mcommit 737e686411a069c0cf73e113c7d5d5c5077090bd[m
Author: j11c <gbjiic@gmail.com>
Date:   Sun Nov 30 14:26:19 2025 -0800

    MUX0 and MUX1 select signals defined as per instruction format.

[33mcommit 310b006ae6931943294a841f17ad02aea493752e[m
Author: j11c <gbjiic@gmail.com>
Date:   Sun Nov 30 11:01:53 2025 -0800

    Added Computer Top module

[33mcommit fde755be08c5b9f8cbad9281e385ef81a2fba843[m
Author: j11c <gbjiic@gmail.com>
Date:   Sun Nov 30 10:58:49 2025 -0800

    Added data inout port to CPU. Port is for interacting with DataMemory data flow.

[33mcommit f5a9752889821c16e19e9efae7024efb35c3940f[m
Author: j11c <gbjiic@gmail.com>
Date:   Sun Nov 30 10:43:43 2025 -0800

    corrected typo in RW out port data type

[33mcommit 36338ab5364d245edd5fe23d14af29956f9c7a95[m
Author: j11c <gbjiic@gmail.com>
Date:   Sat Nov 29 15:11:47 2025 -0800

    UnidadControl arquitecture body layout defined

[33mcommit 7c67f9efc0bd1a01282bf1aeb53b5e4a8597832a[m
Author: j11c <gbjiic@gmail.com>
Date:   Sat Nov 29 14:51:55 2025 -0800

    memoriaDatos arquitecture body updated

[33mcommit 03a9e0ea7a496fdeba50d5e069ebf9d4bca662a2[m
Author: j11c <gbjiic@gmail.com>
Date:   Sat Nov 29 14:43:26 2025 -0800

    RWIO arquitecture body defined

[33mcommit 974f597d6b9a494c750e74c47cb149c00a998345[m
Author: j11c <gbjiic@gmail.com>
Date:   Sat Nov 29 14:37:35 2025 -0800

    first signal structure defined. May need changes

[33mcommit b10e87eb856e7cecaf6ec51b53ee3ffee9d8959a[m
Author: j11c <gbjiic@gmail.com>
Date:   Fri Nov 28 13:35:42 2025 -0800

    CPU layout, all components added. Missing signals.

[33mcommit e1fc25baf83b1a0d5e90fed660d785516072efa9[m
Author: j11c <gbjiic@gmail.com>
Date:   Fri Nov 28 12:58:07 2025 -0800

    CPU components layout. Some components still missing.

[33mcommit 72cc02a385dc1fbfaaffac939de1d1bd57a37a5d[m
Author: j11c <gbjiic@gmail.com>
Date:   Fri Nov 28 12:29:18 2025 -0800

    Added CPU Ports

[33mcommit cd2a0ecc49e97c2eaa2b70eda9e171bcf3fd8db8[m
Author: j11c <gbjiic@gmail.com>
Date:   Thu Nov 20 18:03:18 2025 -0800

    Initial files added

[33mcommit 3638ac557101db3b08d6d1b0b647b9cafc1ac019[m
Author: Joshua Israel Ibarra Cárdenas <65472861+j11c@users.noreply.github.com>
Date:   Thu Nov 20 17:13:42 2025 -0800

    Create .gitignore
