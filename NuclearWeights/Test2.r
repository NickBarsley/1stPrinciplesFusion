

MeV = 1.602176565E???19   # Conversion from Joules to MeV, Wikipedia        
u =  1.660539040E-27    # Conversion from u to kg, Wikipedia
Neutron_Mass = 1.00866491588              #u, WIkipedia
Neutral_Hydrogen_Atom = 1.007825   
U_Adding_Mass = 92 * Neutral_Hydrogen_Atom + 143 * Neutron_Mass
U_Observed_Mass = 235.0439299 # Wikipedia
Delta_Mass = U_Adding_Mass - U_Observed_Mass

C = 299792458 # metres per second
Energy_from_delta_J = Delta_Mass * u * C^2
Energy_from_delta_MeV = Energy_from_delta_J / MeV
U_Nuclean_Count = 92 + 143
U_avg_binding_e_per_nucleon = Energy_from_delta_MeV / U_Nuclean_Count

A = U_Nuclean_Count
Eb = 16*A - 17*(A^(2/3)) - 0.7* (92^2)/(143^(1/3)) - 25 * ((143-92)^2)/(92+143)