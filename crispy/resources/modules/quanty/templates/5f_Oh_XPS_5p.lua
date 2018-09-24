--------------------------------------------------------------------------------
-- Quanty input file generated using Crispy. If you use this file please cite
-- the following reference: http://dx.doi.org/10.5281/zenodo.1008184.
--
-- elements: 5f
-- symmetry: Oh
-- experiment: XPS
-- edge: O2,3 (5p)
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
H_magnetic_field = $H_magnetic_field
H_exchange_field = $H_exchange_field

--------------------------------------------------------------------------------
-- Define the number of electrons, shells, etc.
--------------------------------------------------------------------------------
NBosons = 0
NFermions = 20

NElectrons_5p = 6
NElectrons_5f = $NElectrons_5f

IndexDn_5p = {0, 2, 4}
IndexUp_5p = {1, 3, 5}
IndexDn_5f = {6, 8, 10, 12, 14, 16, 18}
IndexUp_5f = {7, 9, 11, 13, 15, 17, 19}

--------------------------------------------------------------------------------
-- Define the atomic term.
--------------------------------------------------------------------------------
N_5p = NewOperator('Number', NFermions, IndexUp_5p, IndexUp_5p, {1, 1, 1})
     + NewOperator('Number', NFermions, IndexDn_5p, IndexDn_5p, {1, 1, 1})

N_5f = NewOperator('Number', NFermions, IndexUp_5f, IndexUp_5f, {1, 1, 1, 1, 1, 1, 1})
     + NewOperator('Number', NFermions, IndexDn_5f, IndexDn_5f, {1, 1, 1, 1, 1, 1, 1})

if H_atomic == 1 then
    F0_5f_5f = NewOperator('U', NFermions, IndexUp_5f, IndexDn_5f, {1, 0, 0, 0})
    F2_5f_5f = NewOperator('U', NFermions, IndexUp_5f, IndexDn_5f, {0, 1, 0, 0})
    F4_5f_5f = NewOperator('U', NFermions, IndexUp_5f, IndexDn_5f, {0, 0, 1, 0})
    F6_5f_5f = NewOperator('U', NFermions, IndexUp_5f, IndexDn_5f, {0, 0, 0, 1})

    F0_5p_5f = NewOperator('U', NFermions, IndexUp_5p, IndexDn_5p, IndexUp_5f, IndexDn_5f, {1, 0}, {0, 0})
    F2_5p_5f = NewOperator('U', NFermions, IndexUp_5p, IndexDn_5p, IndexUp_5f, IndexDn_5f, {0, 1}, {0, 0})
    G2_5p_5f = NewOperator('U', NFermions, IndexUp_5p, IndexDn_5p, IndexUp_5f, IndexDn_5f, {0, 0}, {1, 0})
    G4_5p_5f = NewOperator('U', NFermions, IndexUp_5p, IndexDn_5p, IndexUp_5f, IndexDn_5f, {0, 0}, {0, 1})

    U_5f_5f_i = $U(5f,5f)_i_value
    F2_5f_5f_i = $F2(5f,5f)_i_value * $F2(5f,5f)_i_scale
    F4_5f_5f_i = $F4(5f,5f)_i_value * $F4(5f,5f)_i_scale
    F6_5f_5f_i = $F6(5f,5f)_i_value * $F6(5f,5f)_i_scale
    F0_5f_5f_i = U_5f_5f_i + 4 / 195 * F2_5f_5f_i + 2 / 143 * F4_5f_5f_i + 100 / 5577 * F6_5f_5f_i

    U_5f_5f_f = $U(5f,5f)_f_value
    F2_5f_5f_f = $F2(5f,5f)_f_value * $F2(5f,5f)_f_scale
    F4_5f_5f_f = $F4(5f,5f)_f_value * $F4(5f,5f)_f_scale
    F6_5f_5f_f = $F6(5f,5f)_f_value * $F6(5f,5f)_f_scale
    F0_5f_5f_f = U_5f_5f_f + 4 / 195 * F2_5f_5f_f + 2 / 143 * F4_5f_5f_f + 100 / 5577 * F6_5f_5f_f
    U_5p_5f_f = $U(5p,5f)_f_value
    F2_5p_5f_f = $F2(5p,5f)_f_value * $F2(5p,5f)_f_scale
    G2_5p_5f_f = $G2(5p,5f)_f_value * $G2(5p,5f)_f_scale
    G4_5p_5f_f = $G4(5p,5f)_f_value * $G4(5p,5f)_f_scale
    F0_5p_5f_f = U_5p_5f_f + 3 / 70 * G2_5p_5f_f + 2 / 63 * G4_5p_5f_f

    H_i = H_i + Chop(
          F0_5f_5f_i * F0_5f_5f
        + F2_5f_5f_i * F2_5f_5f
        + F4_5f_5f_i * F4_5f_5f
        + F6_5f_5f_i * F6_5f_5f)

    H_f = H_f + Chop(
          F0_5f_5f_f * F0_5f_5f
        + F2_5f_5f_f * F2_5f_5f
        + F4_5f_5f_f * F4_5f_5f
        + F6_5f_5f_f * F6_5f_5f
        + F0_5p_5f_f * F0_5p_5f
        + F2_5p_5f_f * F2_5p_5f
        + G2_5p_5f_f * G2_5p_5f
        + G4_5p_5f_f * G4_5p_5f)

    ldots_5f = NewOperator('ldots', NFermions, IndexUp_5f, IndexDn_5f)

    ldots_5p = NewOperator('ldots', NFermions, IndexUp_5p, IndexDn_5p)

    zeta_5f_i = $zeta(5f)_i_value * $zeta(5f)_i_scale

    zeta_5f_f = $zeta(5f)_f_value * $zeta(5f)_f_scale
    zeta_5p_f = $zeta(5p)_f_value * $zeta(5p)_f_scale

    H_i = H_i + Chop(
          zeta_5f_i * ldots_5f)

    H_f = H_f + Chop(
          zeta_5f_f * ldots_5f
        + zeta_5p_f * ldots_5p)
end

--------------------------------------------------------------------------------
-- Define the crystal field term.
--------------------------------------------------------------------------------
if H_crystal_field == 1 then
    -- PotentialExpandedOnClm('Oh', 3, {Ea2u, Et1u, Et2u})
    -- Ea2u_5f = NewOperator('CF', NFermions, IndexUp_5f, IndexDn_5f, PotentialExpandedOnClm('Oh', 3, {1, 0, 0}))
    -- Et2u_5f = NewOperator('CF', NFermions, IndexUp_5f, IndexDn_5f, PotentialExpandedOnClm('Oh', 3, {0, 1, 0}))
    -- Et1u_5f = NewOperator('CF', NFermions, IndexUp_5f, IndexDn_5f, PotentialExpandedOnClm('Oh', 3, {0, 0, 1}))

    A40_5f_i = $A40(5f)_i_value
    A60_5f_i = $A60(5f)_i_value

    Akm_5f_i = {
           {4,  0, A40_5f_i},
           {4, -4, math.sqrt(5/14) * A40_5f_i},
           {4,  4, math.sqrt(5/14) * A40_5f_i},
           {6,  0, A60_5f_i},
           {6, -4, -math.sqrt(7/2) * A60_5f_i},
           {6,  4, -math.sqrt(7/2) * A60_5f_i}}

    io.write('Energies of the 5f orbitals in the initial Hamiltonian (crystal field term only):\n')
    io.write('================\n')
    io.write('Irrep.        E\n')
    io.write('================\n')
    io.write(string.format('a2u     %8.3f\n', -4 / 11 * A40_5f_i +  80 / 143 * A60_5f_i))
    io.write(string.format('t1u     %8.3f\n',  2 / 11 * A40_5f_i + 100 / 429 * A60_5f_i))
    io.write(string.format('t2u     %8.3f\n', -2 / 33 * A40_5f_i -  60 / 143 * A60_5f_i))
    io.write('================\n')
    io.write('\n')

    A40_5f_f = $A40(5f)_f_value
    A60_5f_f = $A60(5f)_f_value

    Akm_5f_f = {
           {4,  0, A40_5f_f},
           {4, -4, math.sqrt(5/14) * A40_5f_f},
           {4,  4, math.sqrt(5/14) * A40_5f_f},
           {6,  0, A60_5f_f},
           {6, -4, -math.sqrt(7/2) * A60_5f_f},
           {6,  4, -math.sqrt(7/2) * A60_5f_f}}

    H_i = H_i + Chop(NewOperator('CF', NFermions, IndexUp_5f, IndexDn_5f, Akm_5f_i))

    H_f = H_f + Chop(NewOperator('CF', NFermions, IndexUp_5f, IndexDn_5f, Akm_5f_f))
end

--------------------------------------------------------------------------------
-- Define the magnetic field and exchange field terms.
--------------------------------------------------------------------------------
Sx_5f = NewOperator('Sx', NFermions, IndexUp_5f, IndexDn_5f)
Sy_5f = NewOperator('Sy', NFermions, IndexUp_5f, IndexDn_5f)
Sz_5f = NewOperator('Sz', NFermions, IndexUp_5f, IndexDn_5f)
Ssqr_5f = NewOperator('Ssqr', NFermions, IndexUp_5f, IndexDn_5f)
Splus_5f = NewOperator('Splus', NFermions, IndexUp_5f, IndexDn_5f)
Smin_5f = NewOperator('Smin', NFermions, IndexUp_5f, IndexDn_5f)

Lx_5f = NewOperator('Lx', NFermions, IndexUp_5f, IndexDn_5f)
Ly_5f = NewOperator('Ly', NFermions, IndexUp_5f, IndexDn_5f)
Lz_5f = NewOperator('Lz', NFermions, IndexUp_5f, IndexDn_5f)
Lsqr_5f = NewOperator('Lsqr', NFermions, IndexUp_5f, IndexDn_5f)
Lplus_5f = NewOperator('Lplus', NFermions, IndexUp_5f, IndexDn_5f)
Lmin_5f = NewOperator('Lmin', NFermions, IndexUp_5f, IndexDn_5f)

Jx_5f = NewOperator('Jx', NFermions, IndexUp_5f, IndexDn_5f)
Jy_5f = NewOperator('Jy', NFermions, IndexUp_5f, IndexDn_5f)
Jz_5f = NewOperator('Jz', NFermions, IndexUp_5f, IndexDn_5f)
Jsqr_5f = NewOperator('Jsqr', NFermions, IndexUp_5f, IndexDn_5f)
Jplus_5f = NewOperator('Jplus', NFermions, IndexUp_5f, IndexDn_5f)
Jmin_5f = NewOperator('Jmin', NFermions, IndexUp_5f, IndexDn_5f)

Tz = NewOperator('Tz', NFermions, IndexUp_5f, IndexDn_5f)

Sx = Sx_5f
Sy = Sy_5f
Sz = Sz_5f

Lx = Lx_5f
Ly = Ly_5f
Lz = Lz_5f

Jx = Jx_5f
Jy = Jy_5f
Jz = Jz_5f


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

--------------------------------------------------------------------------------
-- Define the restrictions and set the number of initial states.
--------------------------------------------------------------------------------
InitialRestrictions = {NFermions, NBosons, {'111111 00000000000000', NElectrons_5p, NElectrons_5p},
                                           {'000000 11111111111111', NElectrons_5f, NElectrons_5f}}

FinalRestrictions = {NFermions, NBosons, {'111111 00000000000000', NElectrons_5p - 1, NElectrons_5p - 1},
                                         {'000000 11111111111111', NElectrons_5f, NElectrons_5f}}

Operators = {H_i, Ssqr, Lsqr, Jsqr, Sz, Lz, Jz, Tz, ldots_5p, N_5p, N_5f, 'dZ'}
header = 'Analysis of the initial Hamiltonian:\n'
header = header .. '=================================================================================================================================\n'
header = header .. 'State         <E>     <S^2>     <L^2>     <J^2>      <Sz>      <Lz>      <Jz>      <Tz>     <l.s>    <N_5p>    <N_5f>          dZ\n'
header = header .. '=================================================================================================================================\n'
footer = '=================================================================================================================================\n'

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
T_5p = {}
for i = 1, NElectrons_5p / 2 do
    T_5p[2*i - 1] = NewOperator('An', NFermions, IndexDn_5p[i])
    T_5p[2*i]     = NewOperator('An', NFermions, IndexUp_5p[i])
end

-- List with the user selected spectra.
spectra = {$spectra}

if next(spectra) == nil then
    return
end

indices_5p = {}
c = 1

spectrum = 'Isotropic'
if ValueInTable(spectrum, spectra) then
    indices_5p[spectrum] = {}
    for j, operator in ipairs(T_5p) do
        table.insert(indices_5p[spectrum], c)
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
    G_5p = CreateSpectra(H_f, T_5p, Psis_i, {{'Emin', Emin}, {'Emax', Emax}, {'NE', NE}, {'Gamma', Gamma}, {'DenseBorder', DenseBorder}})
else
    G_5p = CreateSpectra(H_f, T_5p, Psis_i, {{'Emin', Emin}, {'Emax', Emax}, {'NE', NE}, {'Gamma', Gamma}, {'restrictions', CalculationRestrictions}, {'DenseBorder', DenseBorder}})
end

-- Create a list with the Boltzmann probabilities for a given operator
-- and state.
dZ_5p = {}
for i in ipairs(T_5p) do
    for j in ipairs(Psis_i) do
        table.insert(dZ_5p, dZ[j])
    end
end

spectrum = 'Isotropic'
if ValueInTable(spectrum, spectra) then
    Giso = GetSpectrum(G_5p, T_5p, Psis_i, indices_5p[spectrum], dZ_5p)
    SaveSpectrum(Giso / #T_5p, 'iso')
end

