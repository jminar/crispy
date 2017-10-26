--------------------------------------------------------------------------------
-- Quanty input file generated using Crispy.
--
-- elements: 3d transition metals
-- symmetry: Oh
-- experiment: RIXS
-- edge: L2,3-M4,5 (2p3d)
--------------------------------------------------------------------------------
Verbosity(0x00FF)

--------------------------------------------------------------------------------
-- Initialize the Hamiltonians.
--------------------------------------------------------------------------------
H_i = 0
H_m = 0
H_f = 0

--------------------------------------------------------------------------------
-- Toggle the Hamiltonian terms.
--------------------------------------------------------------------------------
H_atomic              = $H_atomic
H_cf                  = $H_cf
H_3d_Ld_hybridization = $H_3d_Ld_hybridization

--------------------------------------------------------------------------------
-- Define the number of electrons, shells, etc.
--------------------------------------------------------------------------------
NBosons = 0
NFermions = 16

NElectrons_2p = 6
NElectrons_3d = $NElectrons_3d

IndexDn_2p = {0, 2, 4}
IndexUp_2p = {1, 3, 5}
IndexDn_3d = {6, 8, 10, 12, 14}
IndexUp_3d = {7, 9, 11, 13, 15}

if H_3d_Ld_hybridization == 1 then
    NFermions = 26

    NElectrons_Ld = 10

    IndexDn_Ld = {16, 18, 20, 22, 24}
    IndexUp_Ld = {17, 19, 21, 23, 25}
end

--------------------------------------------------------------------------------
-- Define the atomic term.
--------------------------------------------------------------------------------
N_2p = NewOperator('Number', NFermions, IndexUp_2p, IndexUp_2p, {1, 1, 1})
     + NewOperator('Number', NFermions, IndexDn_2p, IndexDn_2p, {1, 1, 1})

N_3d = NewOperator('Number', NFermions, IndexUp_3d, IndexUp_3d, {1, 1, 1, 1, 1})
     + NewOperator('Number', NFermions, IndexDn_3d, IndexDn_3d, {1, 1, 1, 1, 1})

if H_atomic == 1 then
    F0_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {1, 0, 0})
    F2_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 1, 0})
    F4_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 0, 1})

    F0_2p_3d = NewOperator('U', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {1, 0}, {0, 0})
    F2_2p_3d = NewOperator('U', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {0, 1}, {0, 0})
    G1_2p_3d = NewOperator('U', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {0, 0}, {1, 0})
    G3_2p_3d = NewOperator('U', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {0, 0}, {0, 1})

    U_3d_3d_i  = $U(3d,3d)_i_value * $U(3d,3d)_i_scaling
    F2_3d_3d_i = $F2(3d,3d)_i_value * $F2(3d,3d)_i_scaling
    F4_3d_3d_i = $F4(3d,3d)_i_value * $F4(3d,3d)_i_scaling
    F0_3d_3d_i = U_3d_3d_i + 2 / 63 * F2_3d_3d_i + 2 / 63 * F4_3d_3d_i

    U_3d_3d_m  = $U(3d,3d)_m_value * $U(3d,3d)_m_scaling
    F2_3d_3d_m = $F2(3d,3d)_m_value * $F2(3d,3d)_m_scaling
    F4_3d_3d_m = $F4(3d,3d)_m_value * $F4(3d,3d)_m_scaling
    F0_3d_3d_m = U_3d_3d_m + 2 / 63 * F2_3d_3d_m + 2 / 63 * F4_3d_3d_m
    U_2p_3d_m  = $U(2p,3d)_m_value * $U(2p,3d)_m_scaling
    F2_2p_3d_m = $F2(2p,3d)_m_value * $F2(2p,3d)_m_scaling
    G1_2p_3d_m = $G1(2p,3d)_m_value * $G1(2p,3d)_m_scaling
    G3_2p_3d_m = $G3(2p,3d)_m_value * $G3(2p,3d)_m_scaling
    F0_2p_3d_m = U_2p_3d_m + 1 / 15 * G1_2p_3d_m + 3 / 70 * G3_2p_3d_m

    U_3d_3d_f  = $U(3d,3d)_f_value * $U(3d,3d)_f_scaling
    F2_3d_3d_f = $F2(3d,3d)_f_value * $F2(3d,3d)_f_scaling
    F4_3d_3d_f = $F4(3d,3d)_f_value * $F4(3d,3d)_f_scaling
    F0_3d_3d_f = U_3d_3d_f + 2 / 63 * F2_3d_3d_f + 2 / 63 * F4_3d_3d_f

    H_i = H_i
        + F0_3d_3d_i * F0_3d_3d
        + F2_3d_3d_i * F2_3d_3d
        + F4_3d_3d_i * F4_3d_3d

    H_m = H_m
        + F0_3d_3d_m * F0_3d_3d
        + F2_3d_3d_m * F2_3d_3d
        + F4_3d_3d_m * F4_3d_3d
        + F0_2p_3d_m * F0_2p_3d
        + F2_2p_3d_m * F2_2p_3d
        + G1_2p_3d_m * G1_2p_3d
        + G3_2p_3d_m * G3_2p_3d

    H_f = H_f
        + F0_3d_3d_f * F0_3d_3d
        + F2_3d_3d_f * F2_3d_3d
        + F4_3d_3d_f * F4_3d_3d

    ldots_3d = NewOperator('ldots', NFermions, IndexUp_3d, IndexDn_3d)

    ldots_2p = NewOperator('ldots', NFermions, IndexUp_2p, IndexDn_2p)

    zeta_3d_i = $zeta(3d)_i_value * $zeta(3d)_i_scaling

    zeta_3d_m = $zeta(3d)_m_value * $zeta(3d)_m_scaling
    zeta_2p_m = $zeta(2p)_m_value * $zeta(2p)_m_scaling

    zeta_3d_f = $zeta(3d)_f_value * $zeta(3d)_f_scaling

    H_i = H_i
        + zeta_3d_i * ldots_3d

    H_m = H_m
        + zeta_3d_m * ldots_3d
        + zeta_2p_m * ldots_2p

    H_f = H_f
        + zeta_3d_f * ldots_3d
end

--------------------------------------------------------------------------------
-- Define the crystal field term.
--------------------------------------------------------------------------------
if H_cf == 1 then
    -- PotentialExpandedOnClm('Oh', 2, {Eeg, Et2g})
    tenDq_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {0.6, -0.4}))

    tenDq_3d_i = $10Dq(3d)_i_value * $10Dq(3d)_i_scaling

    tenDq_3d_m = $10Dq(3d)_m_value * $10Dq(3d)_m_scaling

    tenDq_3d_f = $10Dq(3d)_f_value * $10Dq(3d)_f_scaling

    H_i = H_i
        + tenDq_3d_i * tenDq_3d

    H_m = H_m
        + tenDq_3d_m * tenDq_3d

    H_f = H_f
        + tenDq_3d_f * tenDq_3d
end

--------------------------------------------------------------------------------
-- Define the 3d-Ld hybridization term.
--------------------------------------------------------------------------------
if H_3d_Ld_hybridization == 1 then
    N_Ld = NewOperator('Number', NFermions, IndexUp_Ld, IndexUp_Ld, {1, 1, 1, 1, 1})
         + NewOperator('Number', NFermions, IndexDn_Ld, IndexDn_Ld, {1, 1, 1, 1, 1})

    Delta_3d_Ld_i = $Delta(3d,Ld)_i_value * $Delta(3d,Ld)_i_scaling
    e_3d_i  = (10 * Delta_3d_Ld_i - NElectrons_3d * (19 + NElectrons_3d) * U_3d_3d_i / 2) / (10 + NElectrons_3d)
    e_Ld_i  = NElectrons_3d * ((1 + NElectrons_3d) * U_3d_3d_i / 2 - Delta_3d_Ld_i) / (10 + NElectrons_3d)

    Delta_3d_Ld_m = $Delta(3d,Ld)_m_value * $Delta(3d,Ld)_m_scaling
    e_2p_m = (10 * Delta_3d_Ld_m + (1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_m / 2 - (10 + NElectrons_3d) * U_2p_3d_m)) / (16 + NElectrons_3d)
    e_3d_m = (10 * Delta_3d_Ld_m - NElectrons_3d * (31 + NElectrons_3d) * U_3d_3d_m / 2 - 90 * U_2p_3d_m) / (16 + NElectrons_3d)
    e_Ld_m = ((1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_m / 2 + 6 * U_2p_3d_m) - (6 + NElectrons_3d) * Delta_3d_Ld_m) / (16 + NElectrons_3d)

    Delta_3d_Ld_f = $Delta(3d,Ld)_f_value * $Delta(3d,Ld)_f_scaling
    e_3d_f  = (10 * Delta_3d_Ld_f - NElectrons_3d * (19 + NElectrons_3d) * U_3d_3d_f / 2) / (10 + NElectrons_3d)
    e_Ld_f  = NElectrons_3d * ((1 + NElectrons_3d) * U_3d_3d_f / 2 - Delta_3d_Ld_f) / (10 + NElectrons_3d)

    H_i = H_i
        + e_3d_i * N_3d
        + e_Ld_i * N_Ld

    H_m = H_m
        + e_2p_m * N_2p
        + e_3d_m * N_3d
        + e_Ld_m * N_Ld

    H_f = H_f
        + e_3d_f * N_3d
        + e_Ld_f * N_Ld

    tenDq_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('Oh', 2, {0.6, -0.4}))

    Vt2g_3d_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {0, 1}))
               + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('Oh', 2, {0, 1}))

    Veg_3d_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {1, 0}))
              + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('Oh', 2, {1, 0}))

    tenDq_Ld_i   = $10Dq(Ld)_i_value * $10Dq(Ld)_i_scaling
    Veg_3d_Ld_i  = $Veg(3d,Ld)_i_value * $Veg(3d,Ld)_i_scaling
    Vt2g_3d_Ld_i = $Vt2g(3d,Ld)_i_value * $Vt2g(3d,Ld)_i_scaling

    tenDq_Ld_m   = $10Dq(Ld)_m_value * $10Dq(Ld)_m_scaling
    Veg_3d_Ld_m  = $Veg(3d,Ld)_m_value * $Veg(3d,Ld)_m_scaling
    Vt2g_3d_Ld_m = $Vt2g(3d,Ld)_m_value * $Vt2g(3d,Ld)_m_scaling

    tenDq_Ld_f   = $10Dq(Ld)_f_value * $10Dq(Ld)_f_scaling
    Veg_3d_Ld_f  = $Veg(3d,Ld)_f_value * $Veg(3d,Ld)_f_scaling
    Vt2g_3d_Ld_f = $Vt2g(3d,Ld)_f_value * $Vt2g(3d,Ld)_f_scaling

    H_i = H_i
        + tenDq_Ld_i   * tenDq_Ld
        + Veg_3d_Ld_i  * Veg_3d_Ld
        + Vt2g_3d_Ld_i * Vt2g_3d_Ld

    H_m = H_m
        + tenDq_Ld_m   * tenDq_Ld
        + Veg_3d_Ld_m  * Veg_3d_Ld
        + Vt2g_3d_Ld_m * Vt2g_3d_Ld

    H_f = H_f
        + tenDq_Ld_f   * tenDq_Ld
        + Veg_3d_Ld_f  * Veg_3d_Ld
        + Vt2g_3d_Ld_f * Vt2g_3d_Ld
end

--------------------------------------------------------------------------------
-- Define the magnetic field term.
--------------------------------------------------------------------------------
Sx_3d    = NewOperator('Sx'   , NFermions, IndexUp_3d, IndexDn_3d)
Sy_3d    = NewOperator('Sy'   , NFermions, IndexUp_3d, IndexDn_3d)
Sz_3d    = NewOperator('Sz'   , NFermions, IndexUp_3d, IndexDn_3d)
Ssqr_3d  = NewOperator('Ssqr' , NFermions, IndexUp_3d, IndexDn_3d)
Splus_3d = NewOperator('Splus', NFermions, IndexUp_3d, IndexDn_3d)
Smin_3d  = NewOperator('Smin' , NFermions, IndexUp_3d, IndexDn_3d)

Lx_3d    = NewOperator('Lx'   , NFermions, IndexUp_3d, IndexDn_3d)
Ly_3d    = NewOperator('Ly'   , NFermions, IndexUp_3d, IndexDn_3d)
Lz_3d    = NewOperator('Lz'   , NFermions, IndexUp_3d, IndexDn_3d)
Lsqr_3d  = NewOperator('Lsqr' , NFermions, IndexUp_3d, IndexDn_3d)
Lplus_3d = NewOperator('Lplus', NFermions, IndexUp_3d, IndexDn_3d)
Lmin_3d  = NewOperator('Lmin' , NFermions, IndexUp_3d, IndexDn_3d)

Jx_3d    = NewOperator('Jx'   , NFermions, IndexUp_3d, IndexDn_3d)
Jy_3d    = NewOperator('Jy'   , NFermions, IndexUp_3d, IndexDn_3d)
Jz_3d    = NewOperator('Jz'   , NFermions, IndexUp_3d, IndexDn_3d)
Jsqr_3d  = NewOperator('Jsqr' , NFermions, IndexUp_3d, IndexDn_3d)
Jplus_3d = NewOperator('Jplus', NFermions, IndexUp_3d, IndexDn_3d)
Jmin_3d  = NewOperator('Jmin' , NFermions, IndexUp_3d, IndexDn_3d)

Sx = Sx_3d
Sy = Sy_3d
Sz = Sz_3d

Lx = Lx_3d
Ly = Ly_3d
Lz = Lz_3d

Jx = Jx_3d
Jy = Jy_3d
Jz = Jz_3d

Ssqr = Sx * Sx + Sy * Sy + Sz * Sz
Lsqr = Lx * Lx + Ly * Ly + Lz * Lz
Jsqr = Jx * Jx + Jy * Jy + Jz * Jz

Bx = $Bx * EnergyUnits.Tesla.value
By = $By * EnergyUnits.Tesla.value
Bz = $Bz * EnergyUnits.Tesla.value

B = Bx * (2 * Sx + Lx)
  + By * (2 * Sy + Ly)
  + Bz * (2 * Sz + Lz)

H_i = H_i
    + B

H_m = H_m
    + B

H_f = H_f
    + B

--------------------------------------------------------------------------------
-- Define the restrictions and set the number of initial states.
--------------------------------------------------------------------------------
InitialRestrictions = {NFermions, NBosons, {'111111 0000000000', NElectrons_2p, NElectrons_2p},
                                           {'000000 1111111111', NElectrons_3d, NElectrons_3d}}

if H_3d_Ld_hybridization == 1 then
    InitialRestrictions = {NFermions, NBosons, {'111111 0000000000 0000000000', NElectrons_2p, NElectrons_2p},
                                               {'000000 1111111111 1111111111', NElectrons_3d + NElectrons_Ld, NElectrons_3d + NElectrons_Ld}}
end

Operators = {H_i, Ssqr, Lsqr, Jsqr, Sz, Lz, Jz, N_2p, N_3d}
header = '\nAnalysis of the initial Hamiltonian:\n'
header = header .. '==============================================================================================\n'
header = header .. '   i       <E>     <S^2>     <L^2>     <J^2>      <Sz>      <Lz>      <Jz>    <N_2p>    <N_3d>\n'
header = header .. '==============================================================================================\n'
footer = '==============================================================================================\n'

if H_3d_Ld_hybridization == 1 then
    Operators = {H_i, Ssqr, Lsqr, Jsqr, Sz, Lz, Jz, N_2p, N_3d, N_Ld}
    header = '\nAnalysis of the initial Hamiltonian:\n'
    header = header .. '========================================================================================================\n'
    header = header .. '   i       <E>     <S^2>     <L^2>     <J^2>      <Sz>      <Lz>      <Jz>    <N_2p>    <N_3d>    <N_Ld>\n'
    header = header .. '========================================================================================================\n'
    footer = '========================================================================================================\n'
end

-- Define the temperature.
T = $T * EnergyUnits.Kelvin.value

 -- Approximate machine epsilon.
epsilon = 2.22e-16
Z = 0

NPsis = $NPsis
NPsisAuto = $NPsisAuto

if NPsisAuto == 1 and NPsis ~= 1 then
    NPsis = 1
    NPsisIncrement = 8
    NPsisIsConverged = false
    dZ = {}

    while not NPsisIsConverged do
        if CalculationRestrictions == nil then
            Psis = Eigensystem(H_i, InitialRestrictions, NPsis)
        else
            Psis = Eigensystem(H_i, InitialRestrictions, NPsis, {{'restrictions', CalculationRestrictions}})
        end

        if not (type(Psis) == 'table') then
            Psis = {Psis}
        end

        E_gs = Psis[1] * H_i * Psis[1]

        for i, Psi in ipairs(Psis) do
            E = Psi * H_i * Psi

            if math.abs(E - E_gs) < epsilon then
                dZ[i] = 1
            else
                dZ[i] = math.exp(-(E - E_gs) / T)
            end

            Z = Z + dZ[i]

            if (dZ[i] / Z) < math.sqrt(epsilon) then
                i = i - 1
                NPsisIsConverged = true
                NPsis = i
                Psis = {unpack(Psis, 1, i)}
                dZ = {unpack(dZ, 1, i)}
                break
            end
        end

        if NPsisIsConverged then
            break
        else
            NPsis = NPsis + NPsisIncrement
        end
    end
    Z = 0
else
        if CalculationRestrictions == nil then
            Psis = Eigensystem(H_i, InitialRestrictions, NPsis)
        else
            Psis = Eigensystem(H_i, InitialRestrictions, NPsis, {{'restrictions', CalculationRestrictions}})
        end

    if not (type(Psis) == 'table') then
        Psis = {Psis}
    end
end

io.write(header)
for i, Psi in ipairs(Psis) do
    io.write(string.format('%4d', i))
    for j, Operator in ipairs(Operators) do
        io.write(string.format('%10.4f', Complex.Re(Psi * Operator * Psi)))
    end
    io.write('\n')
end
io.write(footer)

--------------------------------------------------------------------------------
-- Define the transition operators.
--------------------------------------------------------------------------------
t = math.sqrt(1/2);

Tx_2p_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_2p, IndexDn_2p, {{1, -1, t    }, {1, 1, -t    }})
Ty_2p_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_2p, IndexDn_2p, {{1, -1, t * I}, {1, 1,  t * I}})
Tz_2p_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_2p, IndexDn_2p, {{1,  0, 1    }                })

Tx_3d_2p = NewOperator('CF', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {{1, -1, t    }, {1, 1, -t    }})
Ty_3d_2p = NewOperator('CF', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {{1, -1, t * I}, {1, 1,  t * I}})
Tz_3d_2p = NewOperator('CF', NFermions, IndexUp_2p, IndexDn_2p, IndexUp_3d, IndexDn_3d, {{1,  0, 1    }                })

--------------------------------------------------------------------------------
-- Calculate and save the spectra.
--------------------------------------------------------------------------------
Giso = 0

Emin1 = $Emin1
Emax1 = $Emax1
Gamma1 = $Gamma1
NE1 = $NE1

Emin2 = $Emin2
Emax2 = $Emax2
Gamma2 = $Gamma2
NE2 = $NE2

E_gs = Psis[1] * H_i * Psis[1]

for i, Psi in ipairs(Psis) do
    E = Psi * H_i * Psi

    if math.abs(E - E_gs) < epsilon then
        dZ = 1
    else
        dZ = math.exp(-(E - E_gs) / T)
    end

    if (dZ < math.sqrt(epsilon)) then
        break
    end

    Z = Z + dZ
    for j, OperatorIn in ipairs({Tx_2p_3d, Ty_2p_3d, Tz_2p_3d}) do
        for k, OperatorOut in ipairs({Tx_3d_2p, Ty_3d_2p, Tz_3d_2p}) do
            Giso = Giso + CreateResonantSpectra(H_m, H_f, OperatorIn, OperatorOut, Psi, {{'Emin1', Emin1}, {'Emax1', Emax1}, {'NE1', NE1}, {'Gamma1', Gamma1}, {'Emin2', Emin2}, {'Emax2', Emax2}, {'NE2', NE2}, {'Gamma2', Gamma2}}) * dZ
        end
    end
end

Giso = Giso / Z
Giso.Print({{'file', '$baseName' .. '_iso.spec'}})

