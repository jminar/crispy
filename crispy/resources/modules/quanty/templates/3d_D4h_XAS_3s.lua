--------------------------------------------------------------------------------
-- Quanty input file generated using Crispy. If you use this file please cite
-- the following reference: http://dx.doi.org/10.5281/zenodo.1008184.
--
-- elements: 3d
-- symmetry: D4h
-- experiment: XAS
-- edge: M1 (3s)
--------------------------------------------------------------------------------
Verbosity($Verbosity)

--------------------------------------------------------------------------------
-- Initialize the Hamiltonians.
--------------------------------------------------------------------------------
H_i = 0
H_f = 0

--------------------------------------------------------------------------------
-- Toggle the Hamiltonian terms.
--------------------------------------------------------------------------------
H_atomic = $H_atomic
H_crystal_field = $H_crystal_field
H_3d_ligands_hybridization = $H_3d_ligands_hybridization
H_magnetic_field = $H_magnetic_field
H_exchange_field = $H_exchange_field

--------------------------------------------------------------------------------
-- Define the number of electrons, shells, etc.
--------------------------------------------------------------------------------
NBosons = 0
NFermions = 12

NElectrons_3s = 2
NElectrons_3d = $NElectrons_3d

IndexDn_3s = {0}
IndexUp_3s = {1}
IndexDn_3d = {2, 4, 6, 8, 10}
IndexUp_3d = {3, 5, 7, 9, 11}

if H_3d_ligands_hybridization == 1 then
    NFermions = 22

    NElectrons_Ld = 10

    IndexDn_Ld = {12, 14, 16, 18, 20}
    IndexUp_Ld = {13, 15, 17, 19, 21}
end

--------------------------------------------------------------------------------
-- Define the atomic term.
--------------------------------------------------------------------------------
N_3s = NewOperator('Number', NFermions, IndexUp_3s, IndexUp_3s, {1})
     + NewOperator('Number', NFermions, IndexDn_3s, IndexDn_3s, {1})

N_3d = NewOperator('Number', NFermions, IndexUp_3d, IndexUp_3d, {1, 1, 1, 1, 1})
     + NewOperator('Number', NFermions, IndexDn_3d, IndexDn_3d, {1, 1, 1, 1, 1})

if H_atomic == 1 then
    F0_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {1, 0, 0})
    F2_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 1, 0})
    F4_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 0, 1})

    F0_3s_3d = NewOperator('U', NFermions, IndexUp_3s, IndexDn_3s, IndexUp_3d, IndexDn_3d, {1}, {0})
    G2_3s_3d = NewOperator('U', NFermions, IndexUp_3s, IndexDn_3s, IndexUp_3d, IndexDn_3d, {0}, {1})

    U_3d_3d_i = $U(3d,3d)_i_value
    F2_3d_3d_i = $F2(3d,3d)_i_value * $F2(3d,3d)_i_scale
    F4_3d_3d_i = $F4(3d,3d)_i_value * $F4(3d,3d)_i_scale
    F0_3d_3d_i = U_3d_3d_i + 2 / 63 * F2_3d_3d_i + 2 / 63 * F4_3d_3d_i

    U_3d_3d_f = $U(3d,3d)_f_value
    F2_3d_3d_f = $F2(3d,3d)_f_value * $F2(3d,3d)_f_scale
    F4_3d_3d_f = $F4(3d,3d)_f_value * $F4(3d,3d)_f_scale
    F0_3d_3d_f = U_3d_3d_f + 2 / 63 * F2_3d_3d_f + 2 / 63 * F4_3d_3d_f
    U_3s_3d_f = $U(3s,3d)_f_value
    G2_3s_3d_f = $G2(3s,3d)_f_value * $G2(3s,3d)_f_scale
    F0_3s_3d_f = U_3s_3d_f + 1 / 10 * G2_3s_3d_f

    H_i = H_i + Chop(
          F0_3d_3d_i * F0_3d_3d
        + F2_3d_3d_i * F2_3d_3d
        + F4_3d_3d_i * F4_3d_3d)

    H_f = H_f + Chop(
          F0_3d_3d_f * F0_3d_3d
        + F2_3d_3d_f * F2_3d_3d
        + F4_3d_3d_f * F4_3d_3d
        + F0_3s_3d_f * F0_3s_3d
        + G2_3s_3d_f * G2_3s_3d)

    ldots_3d = NewOperator('ldots', NFermions, IndexUp_3d, IndexDn_3d)

    zeta_3d_i = $zeta(3d)_i_value * $zeta(3d)_i_scale

    zeta_3d_f = $zeta(3d)_f_value * $zeta(3d)_f_scale

    H_i = H_i + Chop(
          zeta_3d_i * ldots_3d)

    H_f = H_f + Chop(
          zeta_3d_f * ldots_3d)
end

--------------------------------------------------------------------------------
-- Define the crystal field term.
--------------------------------------------------------------------------------
if H_crystal_field == 1 then
    -- PotentialExpandedOnClm('D4h', 2, {Ea1g, Eb1g, Eb2g, Eeg})
    -- Dq_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('D4h', 2, { 6,  6, -4, -4}))
    -- Ds_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('D4h', 2, {-2,  2,  2, -1}))
    -- Dt_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('D4h', 2, {-6, -1, -1,  4}))

    Akm = {{4, 0, 21}, {4, -4, 1.5 * sqrt(70)}, {4, 4, 1.5 * sqrt(70)}}
    Dq_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, Akm)

    Akm = {{2, 0, -7}}
    Ds_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, Akm)

    Akm = {{4, 0, -21}}
    Dt_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, Akm)

    Dq_3d_i = $Dq(3d)_i_value
    Ds_3d_i = $Ds(3d)_i_value
    Dt_3d_i = $Dt(3d)_i_value

    io.write('Energies of the 3d orbitals in the initial Hamiltonian (crystal field term only):\n')
    io.write('================\n')
    io.write('Irrep.         E\n')
    io.write('================\n')
    io.write(string.format('eg      %8.3f\n', -4 * Dq_3d_i - Ds_3d_i + 4 * Dt_3d_i))
    io.write(string.format('b2g     %8.3f\n', -4 * Dq_3d_i + 2 * Ds_3d_i - Dt_3d_i ))
    io.write(string.format('a1g     %8.3f\n', 6 * Dq_3d_i - 2 * Ds_3d_i - 6 * Dt_3d_i ))
    io.write(string.format('b1g     %8.3f\n', 6 * Dq_3d_i + 2 * Ds_3d_i - Dt_3d_i ))
    io.write('================\n')
    io.write('\n')

    Dq_3d_f = $Dq(3d)_f_value
    Ds_3d_f = $Ds(3d)_f_value
    Dt_3d_f = $Dt(3d)_f_value

    H_i = H_i + Chop(
          Dq_3d_i * Dq_3d
        + Ds_3d_i * Ds_3d
        + Dt_3d_i * Dt_3d)

    H_f = H_f + Chop(
          Dq_3d_f * Dq_3d
        + Ds_3d_f * Ds_3d
        + Dt_3d_f * Dt_3d)
end

--------------------------------------------------------------------------------
-- Define the 3d-ligands hybridization term.
--------------------------------------------------------------------------------
if H_3d_ligands_hybridization == 1 then
    N_Ld = NewOperator('Number', NFermions, IndexUp_Ld, IndexUp_Ld, {1, 1, 1, 1, 1})
         + NewOperator('Number', NFermions, IndexDn_Ld, IndexDn_Ld, {1, 1, 1, 1, 1})

    Delta_3d_Ld_i = $Delta(3d,Ld)_i_value
    e_3d_i = (10 * Delta_3d_Ld_i - NElectrons_3d * (19 + NElectrons_3d) * U_3d_3d_i / 2) / (10 + NElectrons_3d)
    e_Ld_i = NElectrons_3d * ((1 + NElectrons_3d) * U_3d_3d_i / 2 - Delta_3d_Ld_i) / (10 + NElectrons_3d)

    Delta_3d_Ld_f = $Delta(3d,Ld)_f_value
    e_3d_f = (10 * Delta_3d_Ld_f - NElectrons_3d * (31 + NElectrons_3d) * U_3d_3d_f / 2 - 90 * U_3s_3d_f) / (16 + NElectrons_3d)
    e_3s_f = (10 * Delta_3d_Ld_f + (1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_f / 2 - (10 + NElectrons_3d) * U_3s_3d_f)) / (16 + NElectrons_3d)
    e_Ld_f = ((1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_f / 2 + 6 * U_3s_3d_f) - (6 + NElectrons_3d) * Delta_3d_Ld_f) / (16 + NElectrons_3d)

    H_i = H_i + Chop(
          e_3d_i * N_3d
        + e_Ld_i * N_Ld)

    H_f = H_f + Chop(
          e_3d_f * N_3d
        + e_3s_f * N_3s
        + e_Ld_f * N_Ld)

    Dq_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('D4h', 2, { 6,  6, -4, -4}))
    Ds_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('D4h', 2, {-2,  2,  2, -1}))
    Dt_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('D4h', 2, {-6, -1, -1,  4}))

    Va1g_3d_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('D4h', 2, {1, 0, 0, 0}))
               + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('D4h', 2, {1, 0, 0, 0}))

    Vb1g_3d_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('D4h', 2, {0, 1, 0, 0}))
               + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('D4h', 2, {0, 1, 0, 0}))

    Vb2g_3d_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('D4h', 2, {0, 0, 1, 0}))
               + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('D4h', 2, {0, 0, 1, 0}))

    Veg_3d_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('D4h', 2, {0, 0, 0, 1}))
              + NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('D4h', 2, {0, 0, 0, 1}))

    Dq_Ld_i = $Dq(Ld)_i_value
    Ds_Ld_i = $Ds(Ld)_i_value
    Dt_Ld_i = $Dt(Ld)_i_value
    Va1g_3d_Ld_i = $Va1g(3d,Ld)_i_value
    Vb1g_3d_Ld_i = $Vb1g(3d,Ld)_i_value
    Vb2g_3d_Ld_i = $Vb2g(3d,Ld)_i_value
    Veg_3d_Ld_i = $Veg(3d,Ld)_i_value

    Dq_Ld_f = $Dq(Ld)_f_value
    Ds_Ld_f = $Ds(Ld)_f_value
    Dt_Ld_f = $Dt(Ld)_f_value
    Va1g_3d_Ld_f = $Va1g(3d,Ld)_f_value
    Vb1g_3d_Ld_f = $Vb1g(3d,Ld)_f_value
    Vb2g_3d_Ld_f = $Vb2g(3d,Ld)_f_value
    Veg_3d_Ld_f = $Veg(3d,Ld)_f_value

    H_i = H_i + Chop(
          Dq_Ld_i * Dq_Ld
        + Ds_Ld_i * Ds_Ld
        + Dt_Ld_i * Dt_Ld
        + Va1g_3d_Ld_i * Va1g_3d_Ld
        + Vb1g_3d_Ld_i * Vb1g_3d_Ld
        + Vb2g_3d_Ld_i * Vb2g_3d_Ld
        + Veg_3d_Ld_i  * Veg_3d_Ld)

    H_f = H_f + Chop(
          Dq_Ld_f * Dq_Ld
        + Ds_Ld_f * Ds_Ld
        + Dt_Ld_f * Dt_Ld
        + Va1g_3d_Ld_f * Va1g_3d_Ld
        + Vb1g_3d_Ld_f * Vb1g_3d_Ld
        + Vb2g_3d_Ld_f * Vb2g_3d_Ld
        + Veg_3d_Ld_f  * Veg_3d_Ld)
end

--------------------------------------------------------------------------------
-- Define the magnetic field and exchange field terms.
--------------------------------------------------------------------------------
Sx_3d = NewOperator('Sx', NFermions, IndexUp_3d, IndexDn_3d)
Sy_3d = NewOperator('Sy', NFermions, IndexUp_3d, IndexDn_3d)
Sz_3d = NewOperator('Sz', NFermions, IndexUp_3d, IndexDn_3d)
Ssqr_3d = NewOperator('Ssqr', NFermions, IndexUp_3d, IndexDn_3d)
Splus_3d = NewOperator('Splus', NFermions, IndexUp_3d, IndexDn_3d)
Smin_3d = NewOperator('Smin', NFermions, IndexUp_3d, IndexDn_3d)

Lx_3d = NewOperator('Lx', NFermions, IndexUp_3d, IndexDn_3d)
Ly_3d = NewOperator('Ly', NFermions, IndexUp_3d, IndexDn_3d)
Lz_3d = NewOperator('Lz', NFermions, IndexUp_3d, IndexDn_3d)
Lsqr_3d = NewOperator('Lsqr', NFermions, IndexUp_3d, IndexDn_3d)
Lplus_3d = NewOperator('Lplus', NFermions, IndexUp_3d, IndexDn_3d)
Lmin_3d = NewOperator('Lmin', NFermions, IndexUp_3d, IndexDn_3d)

Jx_3d = NewOperator('Jx', NFermions, IndexUp_3d, IndexDn_3d)
Jy_3d = NewOperator('Jy', NFermions, IndexUp_3d, IndexDn_3d)
Jz_3d = NewOperator('Jz', NFermions, IndexUp_3d, IndexDn_3d)
Jsqr_3d = NewOperator('Jsqr', NFermions, IndexUp_3d, IndexDn_3d)
Jplus_3d = NewOperator('Jplus', NFermions, IndexUp_3d, IndexDn_3d)
Jmin_3d = NewOperator('Jmin', NFermions, IndexUp_3d, IndexDn_3d)

Tz = NewOperator('Tz', NFermions, IndexUp_3d, IndexDn_3d)

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

if H_magnetic_field == 1 then
    Bx_i = $Bx_i_value
    By_i = $By_i_value
    Bz_i = $Bz_i_value

    Bx_f = $Bx_f_value
    By_f = $By_f_value
    Bz_f = $Bz_f_value

    H_i = H_i + Chop(
          Bx_i * (2 * Sx + Lx)
        + By_i * (2 * Sy + Ly)
        + Bz_i * (2 * Sz + Lz))

    H_f = H_f + Chop(
          Bx_f * (2 * Sx + Lx)
        + By_f * (2 * Sy + Ly)
        + Bz_f * (2 * Sz + Lz))
end

if H_exchange_field == 1 then
    Hx_i = $Hx_i_value
    Hy_i = $Hy_i_value
    Hz_i = $Hz_i_value

    Hx_f = $Hx_f_value
    Hy_f = $Hy_f_value
    Hz_f = $Hz_f_value

    H_i = H_i + Chop(
          Hx_i * Sx
        + Hy_i * Sy
        + Hz_i * Sz)

    H_f = H_f + Chop(
          Hx_f * Sx
        + Hy_f * Sy
        + Hz_f * Sz)
end

NConfigurations = $NConfigurations

--------------------------------------------------------------------------------
-- Define the restrictions and set the number of initial states.
--------------------------------------------------------------------------------
InitialRestrictions = {NFermions, NBosons, {'11 0000000000', NElectrons_3s, NElectrons_3s},
                                           {'00 1111111111', NElectrons_3d, NElectrons_3d}}

FinalRestrictions = {NFermions, NBosons, {'11 0000000000', NElectrons_3s - 1, NElectrons_3s - 1},
                                         {'00 1111111111', NElectrons_3d + 1, NElectrons_3d + 1}}

if H_3d_ligands_hybridization == 1 then
    InitialRestrictions = {NFermions, NBosons, {'11 0000000000 0000000000', NElectrons_3s, NElectrons_3s},
                                               {'00 1111111111 0000000000', NElectrons_3d, NElectrons_3d},
                                               {'00 0000000000 1111111111', NElectrons_Ld, NElectrons_Ld}}

    FinalRestrictions = {NFermions, NBosons, {'11 0000000000 0000000000', NElectrons_3s - 1, NElectrons_3s - 1},
                                             {'00 1111111111 0000000000', NElectrons_3d + 1, NElectrons_3d + 1},
                                             {'00 0000000000 1111111111', NElectrons_Ld, NElectrons_Ld}}

    CalculationRestrictions = {NFermions, NBosons, {'00 0000000000 1111111111', NElectrons_Ld - (NConfigurations - 1), NElectrons_Ld}}
end

Operators = {H_i, Ssqr, Lsqr, Jsqr, Sz, Lz, Jz, Tz, ldots_3d, N_3s, N_3d, 'dZ'}
header = 'Analysis of the initial Hamiltonian:\n'
header = header .. '=================================================================================================================================\n'
header = header .. 'State         <E>     <S^2>     <L^2>     <J^2>      <Sz>      <Lz>      <Jz>      <Tz>     <l.s>    <N_3s>    <N_3d>          dZ\n'
header = header .. '=================================================================================================================================\n'
footer = '=================================================================================================================================\n'

if H_3d_ligands_hybridization == 1 then
    Operators = {H_i, Ssqr, Lsqr, Jsqr, Sz, Lz, Jz, Tz, ldots_3d, N_3s, N_3d, N_Ld, 'dZ'}
    header = 'Analysis of the initial Hamiltonian:\n'
    header = header .. '===========================================================================================================================================\n'
    header = header .. 'State         <E>     <S^2>     <L^2>     <J^2>      <Sz>      <Lz>      <Jz>      <Tz>     <l.s>    <N_3s>    <N_3d>    <N_Ld>          dZ\n'
    header = header .. '===========================================================================================================================================\n'
    footer = '===========================================================================================================================================\n'
end

T = $T * EnergyUnits.Kelvin.value

-- Approximate machine epsilon for single precision arithmetics.
epsilon = 1.19e-07

NPsis = $NPsis
NPsisAuto = $NPsisAuto

dZ = {}

if NPsisAuto == 1 and NPsis ~= 1 then
    NPsis = 4
    NPsisIncrement = 8
    NPsisIsConverged = false

    while not NPsisIsConverged do
        if CalculationRestrictions == nil then
            Psis_i = Eigensystem(H_i, InitialRestrictions, NPsis)
        else
            Psis_i = Eigensystem(H_i, InitialRestrictions, NPsis, {{'restrictions', CalculationRestrictions}})
        end

        if not (type(Psis_i) == 'table') then
            Psis_i = {Psis_i}
        end

        E_gs_i = Psis_i[1] * H_i * Psis_i[1]

        Z = 0

        for i, Psi in ipairs(Psis_i) do
            E = Psi * H_i * Psi

            if math.abs(E - E_gs_i) < epsilon then
                dZ[i] = 1
            else
                dZ[i] = math.exp(-(E - E_gs_i) / T)
            end

            Z = Z + dZ[i]

            if (dZ[i] / Z) < math.sqrt(epsilon) then
                i = i - 1
                NPsisIsConverged = true
                NPsis = i
                Psis_i = {unpack(Psis_i, 1, i)}
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
else
    if CalculationRestrictions == nil then
        Psis_i = Eigensystem(H_i, InitialRestrictions, NPsis)
    else
        Psis_i = Eigensystem(H_i, InitialRestrictions, NPsis, {{'restrictions', CalculationRestrictions}})
    end

    if not (type(Psis_i) == 'table') then
        Psis_i = {Psis_i}
    end
        E_gs_i = Psis_i[1] * H_i * Psis_i[1]

    Z = 0

    for i, Psi in ipairs(Psis_i) do
        E = Psi * H_i * Psi

        if math.abs(E - E_gs_i) < epsilon then
            dZ[i] = 1
        else
            dZ[i] = math.exp(-(E - E_gs_i) / T)
        end

        Z = Z + dZ[i]
    end
end

-- Normalize dZ to unity.
for i in ipairs(dZ) do
    dZ[i] = dZ[i] / Z
end

-- Print details about the initial Hamiltonian.
io.write(header)
for i, Psi in ipairs(Psis_i) do
    io.write(string.format('%5d', i))
    for j, Operator in ipairs(Operators) do
        if j == 1 then
            io.write(string.format('%12.6f', Complex.Re(Psi * Operator * Psi)))
        elseif Operator == 'dZ' then
            io.write(string.format('%12.2E', dZ[i]))
        else
            io.write(string.format('%10.4f', Complex.Re(Psi * Operator * Psi)))
        end
    end
    io.write('\n')
end
io.write(footer)

--------------------------------------------------------------------------------
-- Define some helper function for the spectra calculation.
--------------------------------------------------------------------------------
function ValueInTable(value, table)
    -- Check if a value is in a table.
    for k, v in ipairs(table) do
        if value == v then
            return true
        end
    end
    return false
end

function GetSpectrum(G, T, Psis, indices, dZSpectra)
    -- Extract the spectra corresponding to the operators identified
    -- using the indices argument. The returned spectrum is a weighted
    -- sum, where the weights are the Boltzmann probabilities.
    if not (type(indices) == 'table') then
        indices = {indices}
    end

    c = 1
    dZSpectrum = {}

    for i in ipairs(T) do
        for k in ipairs(Psis) do
            if ValueInTable(i, indices) then
                table.insert(dZSpectrum, dZSpectra[c])
            else
                table.insert(dZSpectrum, 0)
            end
            c = c + 1
        end
    end

    return Spectra.Sum(G, dZSpectrum)
end

function SaveSpectrum(G, suffix)
    -- Scale, broaden, and save the spectrum to disk.
    G = -1 / math.pi * G

    Gmin1 = $Gmin1 - Gamma
    Gmax1 = $Gmax1 - Gamma
    Egamma1 = ($Egamma1 - Eedge1) + DeltaE
    G.Broaden(0, {{Emin, Gmin1}, {Egamma1, Gmin1}, {Egamma1, Gmax1}, {Emax, Gmax1}})

    G.Print({{'file', '$BaseName_' .. suffix .. '.spec'}})
end

--------------------------------------------------------------------------------
-- Define the transition operators.
--------------------------------------------------------------------------------
t = math.sqrt(1/2)

Txy_3s_3d   = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2, -2, t * I}, {2, 2, -t * I}})
Txz_3s_3d   = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2, -1, t    }, {2, 1, -t    }})
Tyz_3s_3d   = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2, -1, t * I}, {2, 1,  t * I}})
Tx2y2_3s_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2, -2, t    }, {2, 2,  t    }})
Tz2_3s_3d   = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2,  0, 1    }                })

k = $k1
ev = $eps11
eh = $eps12

-- Calculate the right and left polarization vectors.
er = {t * (eh[1] - I * ev[1]),
      t * (eh[2] - I * ev[2]),
      t * (eh[3] - I * ev[3])}

el = {-t * (eh[1] + I * ev[1]),
      -t * (eh[2] + I * ev[2]),
      -t * (eh[3] + I * ev[3])}

function CalculateT(e, k)
    -- Calculate the transition operator for arbitrary
    -- polarization and wave vectors.
    T = (e[1] * k[2] + e[2] * k[1]) * Txy_3s_3d
      + (e[1] * k[3] + e[3] * k[1]) * Txz_3s_3d
      + (e[2] * k[3] + e[3] * k[2]) * Tyz_3s_3d
      + (e[1] * k[1] + e[2] * k[2]) * Tx2y2_3s_3d
      + e[3] * k[3] * Tz2_3s_3d
    return Chop(T)
end

Tv_3s_3d = CalculateT(ev, k)
Th_3s_3d = CalculateT(eh, k)
Tr_3s_3d = CalculateT(er, k)
Tl_3s_3d = CalculateT(el, k)
Tk_3s_3d = CalculateT(k, k)

-- List with the user selected spectra.
spectra = {$spectra}

if next(spectra) == nil then
    return
end

-- Create two lists, one with the operators and the second with
-- the indices of the operators required to calculate a given
-- spectrum.
T_3s_3d = {}
indices_3s_3d = {}
c = 1

spectrum = 'Isotropic'
if ValueInTable(spectrum, spectra) then
    indices_3s_3d[spectrum] = {}
    for j, operator in ipairs({Txy_3s_3d, Txz_3s_3d, Tyz_3s_3d, Tx2y2_3s_3d, Tz2_3s_3d}) do
        table.insert(T_3s_3d, operator)
        table.insert(indices_3s_3d[spectrum], c)
        c = c + 1
    end
end

spectrum = 'Circular Dichroism'
if ValueInTable(spectrum, spectra) then
    indices_3s_3d[spectrum] = {}
    for j, operator in ipairs({Tr_3s_3d, Tl_3s_3d}) do
        table.insert(T_3s_3d, operator)
        table.insert(indices_3s_3d[spectrum], c)
        c = c + 1
    end
end

spectrum = 'Linear Dichroism'
if ValueInTable(spectrum, spectra) then
    indices_3s_3d[spectrum] = {}
    for j, operator in ipairs({Tv_3s_3d, Th_3s_3d}) do
        table.insert(T_3s_3d, operator)
        table.insert(indices_3s_3d[spectrum], c)
        c = c + 1
    end
end

--------------------------------------------------------------------------------
-- Calculate and save the spectra.
--------------------------------------------------------------------------------
E_gs_i = Psis_i[1] * H_i * Psis_i[1]

if CalculationRestrictions == nil then
    Psis_f = Eigensystem(H_f, FinalRestrictions, 1)
else
    Psis_f = Eigensystem(H_f, FinalRestrictions, 1, {{'restrictions', CalculationRestrictions}})
end

Psis_f = {Psis_f}
E_gs_f = Psis_f[1] * H_f * Psis_f[1]

Eedge1 = $Eedge1
DeltaE = E_gs_f - E_gs_i

Emin = ($Emin1 - Eedge1) + DeltaE
Emax = ($Emax1 - Eedge1) + DeltaE
NE = $NE1
Gamma = $Gamma1
DenseBorder = $DenseBorder

if CalculationRestrictions == nil then
    G_3s_3d = CreateSpectra(H_f, T_3s_3d, Psis_i, {{'Emin', Emin}, {'Emax', Emax}, {'NE', NE}, {'Gamma', Gamma}, {'DenseBorder', DenseBorder}})
else
    G_3s_3d = CreateSpectra(H_f, T_3s_3d, Psis_i, {{'Emin', Emin}, {'Emax', Emax}, {'NE', NE}, {'Gamma', Gamma}, {'restrictions', CalculationRestrictions}, {'DenseBorder', DenseBorder}})
end

-- Create a list with the Boltzmann probabilities for a given operator
-- and state.
dZ_3s_3d = {}
for i in ipairs(T_3s_3d) do
    for j in ipairs(Psis_i) do
        table.insert(dZ_3s_3d, dZ[j])
    end
end

spectrum = 'Isotropic'
if ValueInTable(spectrum, spectra) then
        Giso = GetSpectrum(G_3s_3d, T_3s_3d, Psis_i, indices_3s_3d[spectrum], dZ_3s_3d)
        Giso = Giso / 15
        SaveSpectrum(Giso, 'iso')
end

spectrum = 'Circular Dichroism'
if ValueInTable(spectrum, spectra) then
        Gr = GetSpectrum(G_3s_3d, T_3s_3d, Psis_i, indices_3s_3d[spectrum][1], dZ_3s_3d)
        Gl = GetSpectrum(G_3s_3d, T_3s_3d, Psis_i, indices_3s_3d[spectrum][2], dZ_3s_3d)
        SaveSpectrum(Gr, 'r')
        SaveSpectrum(Gl, 'l')
        SaveSpectrum(Gr - Gl, 'cd')
end

spectrum = 'Linear Dichroism'
if ValueInTable(spectrum, spectra) then
        Gv = GetSpectrum(G_3s_3d, T_3s_3d, Psis_i, indices_3s_3d[spectrum][1], dZ_3s_3d)
        Gh = GetSpectrum(G_3s_3d, T_3s_3d, Psis_i, indices_3s_3d[spectrum][2], dZ_3s_3d)
        SaveSpectrum(Gv, 'v')
        SaveSpectrum(Gh, 'h')
        SaveSpectrum(Gv - Gh, 'ld')
end

