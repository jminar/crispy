--------------------------------------------------------------------------------
-- Quanty input file generated using Crispy. If you use this file please cite
-- the following reference: http://dx.doi.org/10.5281/zenodo.1008184.
--
-- elements: 5d
-- symmetry: D3h
-- experiment: XAS
-- edge: L2,3 (2p)
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
-- Set the verbosity of the calculation. For increased verbosity use the values
-- 0x00FF or 0xFFFF.
--------------------------------------------------------------------------------
Verbosity($Verbosity)

--------------------------------------------------------------------------------
-- Define the parameters of the calculation.
--------------------------------------------------------------------------------
Temperature = $Temperature -- temperature (Kelvin)

NPsis = $NPsis  -- number of states to consider in the spectra calculation
NPsisAuto = $NPsisAuto  -- determine the number of state automatically
NConfigurations = $NConfigurations  -- number of configurations

Emin = $XEmin  -- minimum value of the energy range (eV)
Emax = $XEmax  -- maximum value of the energy range (eV)
NPoints = $XNPoints  -- number of points of the spectra
ExperimentalShift = $XExperimentalShift  -- experimental edge energy (eV)
ZeroShift = $XZeroShift  -- energy required to shift the calculated spectrum to start from approximately zero (eV)
Gaussian = $XGaussian  -- Gaussian FWHM (eV)
Lorentzian = $XLorentzian  -- Lorentzian FWHM (eV)
Gamma = 0.1  -- Lorentzian FWHM used in the spectra calculation (eV)

WaveVector = $XWaveVector  -- wave vector
Ev = $XFirstPolarization  -- vertical polarization
Eh = $XSecondPolarization  -- horizontal polarization

SpectraToCalculate = $SpectraToCalculate  -- types of spectra to calculate
DenseBorder = $DenseBorder -- number of determinants where we switch from dense methods to sparse methods

Prefix = "$Prefix"  -- file name prefix

--------------------------------------------------------------------------------
-- Toggle the Hamiltonian terms.
--------------------------------------------------------------------------------
AtomicTerm = $AtomicTerm
CrystalFieldTerm = $CrystalFieldTerm
MagneticFieldTerm = $MagneticFieldTerm
ExchangeFieldTerm = $ExchangeFieldTerm

--------------------------------------------------------------------------------
-- Define the number of electrons, shells, etc.
--------------------------------------------------------------------------------
NBosons = 0
NFermions = 16

NElectrons_2p = 6
NElectrons_5d = $NElectrons_5d

IndexDn_2p = {0, 2, 4}
IndexUp_2p = {1, 3, 5}
IndexDn_5d = {6, 8, 10, 12, 14}
IndexUp_5d = {7, 9, 11, 13, 15}

--------------------------------------------------------------------------------
-- Initialize the Hamiltonians.
--------------------------------------------------------------------------------
H_i = 0
H_f = 0

--------------------------------------------------------------------------------
-- Define the atomic term.
--------------------------------------------------------------------------------
N_2p = NewOperator("Number", NFermions, IndexUp_2p, IndexUp_2p, {1, 1, 1})
     + NewOperator("Number", NFermions, IndexDn_2p, IndexDn_2p, {1, 1, 1})

N_5d = NewOperator("Number", NFermions, IndexUp_5d, IndexUp_5d, {1, 1, 1, 1, 1})
     + NewOperator("Number", NFermions, IndexDn_5d, IndexDn_5d, {1, 1, 1, 1, 1})

if AtomicTerm then
    F0_5d_5d = NewOperator("U", NFermions, IndexUp_5d, IndexDn_5d, {1, 0, 0})
    F2_5d_5d = NewOperator("U", NFermions, IndexUp_5d, IndexDn_5d, {0, 1, 0})
    F4_5d_5d = NewOperator("U", NFermions, IndexUp_5d, IndexDn_5d, {0, 0, 1})

    F0_2p_5d = NewOperator("U", NFermions, IndexUp_2p, IndexDn_2p, IndexUp_5d, IndexDn_5d, {1, 0}, {0, 0})
    F2_2p_5d = NewOperator("U", NFermions, IndexUp_2p, IndexDn_2p, IndexUp_5d, IndexDn_5d, {0, 1}, {0, 0})
    G1_2p_5d = NewOperator("U", NFermions, IndexUp_2p, IndexDn_2p, IndexUp_5d, IndexDn_5d, {0, 0}, {1, 0})
    G3_2p_5d = NewOperator("U", NFermions, IndexUp_2p, IndexDn_2p, IndexUp_5d, IndexDn_5d, {0, 0}, {0, 1})

    U_5d_5d_i = $U(5d,5d)_i_value
    F2_5d_5d_i = $F2(5d,5d)_i_value * $F2(5d,5d)_i_scaleFactor
    F4_5d_5d_i = $F4(5d,5d)_i_value * $F4(5d,5d)_i_scaleFactor
    F0_5d_5d_i = U_5d_5d_i + 2 / 63 * F2_5d_5d_i + 2 / 63 * F4_5d_5d_i

    U_5d_5d_f = $U(5d,5d)_f_value
    F2_5d_5d_f = $F2(5d,5d)_f_value * $F2(5d,5d)_f_scaleFactor
    F4_5d_5d_f = $F4(5d,5d)_f_value * $F4(5d,5d)_f_scaleFactor
    F0_5d_5d_f = U_5d_5d_f + 2 / 63 * F2_5d_5d_f + 2 / 63 * F4_5d_5d_f
    U_2p_5d_f = $U(2p,5d)_f_value
    F2_2p_5d_f = $F2(2p,5d)_f_value * $F2(2p,5d)_f_scaleFactor
    G1_2p_5d_f = $G1(2p,5d)_f_value * $G1(2p,5d)_f_scaleFactor
    G3_2p_5d_f = $G3(2p,5d)_f_value * $G3(2p,5d)_f_scaleFactor
    F0_2p_5d_f = U_2p_5d_f + 1 / 15 * G1_2p_5d_f + 3 / 70 * G3_2p_5d_f

    H_i = H_i + Chop(
          F0_5d_5d_i * F0_5d_5d
        + F2_5d_5d_i * F2_5d_5d
        + F4_5d_5d_i * F4_5d_5d)

    H_f = H_f + Chop(
          F0_5d_5d_f * F0_5d_5d
        + F2_5d_5d_f * F2_5d_5d
        + F4_5d_5d_f * F4_5d_5d
        + F0_2p_5d_f * F0_2p_5d
        + F2_2p_5d_f * F2_2p_5d
        + G1_2p_5d_f * G1_2p_5d
        + G3_2p_5d_f * G3_2p_5d)

    ldots_5d = NewOperator("ldots", NFermions, IndexUp_5d, IndexDn_5d)

    ldots_2p = NewOperator("ldots", NFermions, IndexUp_2p, IndexDn_2p)

    zeta_5d_i = $zeta(5d)_i_value * $zeta(5d)_i_scaleFactor

    zeta_5d_f = $zeta(5d)_f_value * $zeta(5d)_f_scaleFactor
    zeta_2p_f = $zeta(2p)_f_value * $zeta(2p)_f_scaleFactor

    H_i = H_i + Chop(
          zeta_5d_i * ldots_5d)

    H_f = H_f + Chop(
          zeta_5d_f * ldots_5d
        + zeta_2p_f * ldots_2p)
end

--------------------------------------------------------------------------------
-- Define the crystal field term.
--------------------------------------------------------------------------------
if CrystalFieldTerm then
    Dmu_5d = NewOperator("CF", NFermions, IndexUp_5d, IndexDn_5d, {{2, 0, -7}})
    Dnu_5d = NewOperator("CF", NFermions, IndexUp_5d, IndexDn_5d, {{4, 0, -21}})

    Dmu_5d_i = $Dmu(5d)_i_value
    Dnu_5d_i = $Dnu(5d)_i_value

    io.write("Diagonal values of the initial crystal field Hamiltonian:\n")
    io.write("================\n")
    io.write("Irrep.         E\n")
    io.write("================\n")
    io.write(string.format("a'1     %8.3f\n", -2 * Dmu_5d_i - 6 * Dnu_5d_i))
    io.write(string.format("e'      %8.3f\n", 2 * Dmu_5d_i - Dnu_5d_i))
    io.write(string.format("e''     %8.3f\n", -Dmu_5d_i + 4 * Dnu_5d_i))
    io.write("================\n")
    io.write("\n")

    Dmu_5d_f = $Dmu(5d)_f_value
    Dnu_5d_f = $Dnu(5d)_f_value

    H_i = H_i + Chop(
          Dmu_5d_i * Dmu_5d
        + Dnu_5d_i * Dnu_5d)

    H_f = H_f + Chop(
          Dmu_5d_f * Dmu_5d
        + Dnu_5d_f * Dnu_5d)
end
--------------------------------------------------------------------------------
-- Define the magnetic field and exchange field terms.
--------------------------------------------------------------------------------
Sx_5d = NewOperator("Sx", NFermions, IndexUp_5d, IndexDn_5d)
Sy_5d = NewOperator("Sy", NFermions, IndexUp_5d, IndexDn_5d)
Sz_5d = NewOperator("Sz", NFermions, IndexUp_5d, IndexDn_5d)
Ssqr_5d = NewOperator("Ssqr", NFermions, IndexUp_5d, IndexDn_5d)
Splus_5d = NewOperator("Splus", NFermions, IndexUp_5d, IndexDn_5d)
Smin_5d = NewOperator("Smin", NFermions, IndexUp_5d, IndexDn_5d)

Lx_5d = NewOperator("Lx", NFermions, IndexUp_5d, IndexDn_5d)
Ly_5d = NewOperator("Ly", NFermions, IndexUp_5d, IndexDn_5d)
Lz_5d = NewOperator("Lz", NFermions, IndexUp_5d, IndexDn_5d)
Lsqr_5d = NewOperator("Lsqr", NFermions, IndexUp_5d, IndexDn_5d)
Lplus_5d = NewOperator("Lplus", NFermions, IndexUp_5d, IndexDn_5d)
Lmin_5d = NewOperator("Lmin", NFermions, IndexUp_5d, IndexDn_5d)

Jx_5d = NewOperator("Jx", NFermions, IndexUp_5d, IndexDn_5d)
Jy_5d = NewOperator("Jy", NFermions, IndexUp_5d, IndexDn_5d)
Jz_5d = NewOperator("Jz", NFermions, IndexUp_5d, IndexDn_5d)
Jsqr_5d = NewOperator("Jsqr", NFermions, IndexUp_5d, IndexDn_5d)
Jplus_5d = NewOperator("Jplus", NFermions, IndexUp_5d, IndexDn_5d)
Jmin_5d = NewOperator("Jmin", NFermions, IndexUp_5d, IndexDn_5d)

Tx_5d = NewOperator("Tx", NFermions, IndexUp_5d, IndexDn_5d)
Ty_5d = NewOperator("Ty", NFermions, IndexUp_5d, IndexDn_5d)
Tz_5d = NewOperator("Tz", NFermions, IndexUp_5d, IndexDn_5d)

Sx = Sx_5d
Sy = Sy_5d
Sz = Sz_5d

Lx = Lx_5d
Ly = Ly_5d
Lz = Lz_5d

Jx = Jx_5d
Jy = Jy_5d
Jz = Jz_5d

Tx = Tx_5d
Ty = Ty_5d
Tz = Tz_5d

Ssqr = Sx * Sx + Sy * Sy + Sz * Sz
Lsqr = Lx * Lx + Ly * Ly + Lz * Lz
Jsqr = Jx * Jx + Jy * Jy + Jz * Jz

if MagneticFieldTerm then
    Bx_i = $Bx_i_value * EnergyUnits.Tesla.value
    By_i = $By_i_value * EnergyUnits.Tesla.value
    Bz_i = $Bz_i_value * EnergyUnits.Tesla.value

    Bx_f = $Bx_f_value * EnergyUnits.Tesla.value
    By_f = $By_f_value * EnergyUnits.Tesla.value
    Bz_f = $Bz_f_value * EnergyUnits.Tesla.value

    H_i = H_i + Chop(
          Bx_i * (2 * Sx + Lx)
        + By_i * (2 * Sy + Ly)
        + Bz_i * (2 * Sz + Lz))

    H_f = H_f + Chop(
          Bx_f * (2 * Sx + Lx)
        + By_f * (2 * Sy + Ly)
        + Bz_f * (2 * Sz + Lz))
end

if ExchangeFieldTerm then
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
-- Define some helper functions.
--------------------------------------------------------------------------------
function MatrixToOperator(Matrix, StartIndex)
    -- Transform a matrix to an operator.
    local Operator = 0
    for i = 1, #Matrix do
        for j = 1, #Matrix do
            local Weight = Matrix[i][j]
            Operator = Operator + NewOperator("Number", #Matrix + StartIndex, i + StartIndex - 1, j + StartIndex - 1) * Weight
        end
    end
    Operator.Chop()
    return Operator
end

function ValueInTable(Value, Table)
    -- Check if a value is in a table.
    for _, v in ipairs(Table) do
        if Value == v then
            return true
        end
    end
    return false
end

function GetSpectrum(G, Ids, dZ, NOperators, NPsis)
    -- Extract the spectrum corresponding to the operators identified
    -- using the Ids argument. The returned spectrum is a weighted
    -- sum where the weights are the Boltzmann probabilities.
    --
    -- @param G: spectrum object as returned by the functions defined in Quanty, i.e. one spectrum
    --           for each operator and each wavefunction.
    -- @param Ids: indexes of the operators that are considered in the returned spectrum
    -- @param dZ: Boltzmann prefactors for each of the spectrum in the spectra object
    -- @param NOperators: number of transition operators
    -- @param NPsis: number of wavefunctions

    if not (type(Ids) == "table") then
        Ids = {Ids}
    end

    local Id = 1
    local dZs = {}

    for i = 1, NOperators do
        for _ = 1, NPsis do
            if ValueInTable(i, Ids) then
                table.insert(dZs, dZ[Id])
            else
                table.insert(dZs, 0)
            end
            Id = Id + 1
        end
    end
    return Spectra.Sum(G, dZs)
end

function SaveSpectrum(G, Filename, Gaussian, Lorentzian, Pcl)
    G = -1 / math.pi / Pcl * G
    G.Broaden(Gaussian, Lorentzian)
    G.Print({{"file", Filename .. ".spec"}})
end

function DotProduct(a, b)
    return Chop(a[1] * b[1] + a[2] * b[2] + a[3] * b[3])
end

function WavefunctionsAndBoltzmannFactors(H, NPsis, NPsisAuto, Temperature, Threshold, StartRestrictions, CalculationRestrictions)
    -- Calculate the wavefunctions and Boltzmann factors of a Hamiltonian.
    --
    -- @param H: Hamiltonian for which to calculate the wavefunctions
    -- @param NPsis: number of wavefunctions
    -- @param NPsisAuto: determine automatically the number of wavefunctions that are populated at the specified
    --                   temperature and within the threshold
    -- @param Temperature: temperature in eV
    -- @param Threshold: threshold used to determine the number of wavefunction in the automatic procedure
    -- @param StartRestrictions: occupancy restrictions at the start of the calculation
    -- @param CalculationRestrictions: restrictions during the calculation
    -- @return Psis: wavefunctions
    -- @return dZ: Boltzmann factors

    if Threshold == nil then
        Threshold = 1e-8
    end

    local dZ = {}
    local Z = 0
    local Psis

    if NPsisAuto == true and NPsis ~= 1 then
        NPsis = 4
        local NpsisIncrement = 8
        local NPsisIsConverged = false

        while not NPsisIsConverged do
            if CalculationRestrictions == nil then
                Psis = Eigensystem(H, StartRestrictions, NPsis)
            else
                Psis = Eigensystem(H, StartRestrictions, NPsis, {{"restrictions", CalculationRestrictions}})
            end

            if not (type(Psis) == "table") then
                Psis = {Psis}
            end

            if E_gs == nil then
                E_gs = Psis[1] * H * Psis[1]
            end

            Z = 0

            for i, Psi in ipairs(Psis) do
                local E = Psi * H * Psi

                if math.abs(E - E_gs) < Threshold ^ 2 then
                    dZ[i] = 1
                else
                    dZ[i] = math.exp(-(E - E_gs) / Temperature)
                end

                Z = Z + dZ[i]

                if dZ[i] / Z < Threshold then
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
                NPsis = NPsis + NpsisIncrement
            end
        end
    else
        if CalculationRestrictions == nil then
            Psis = Eigensystem(H, StartRestrictions, NPsis)
        else
            Psis = Eigensystem(H, StartRestrictions, NPsis, {{"restrictions", CalculationRestrictions}})
        end

        if not (type(Psis) == "table") then
            Psis = {Psis}
        end

        local E_gs = Psis[1] * H * Psis[1]

        Z = 0

        for i, psi in ipairs(Psis) do
            local E = psi * H * psi

            if math.abs(E - E_gs) < Threshold ^ 2 then
                dZ[i] = 1
            else
                dZ[i] = math.exp(-(E - E_gs) / Temperature)
            end

            Z = Z + dZ[i]
        end
    end

    -- Normalize the Boltzmann factors to unity.
    for i in ipairs(dZ) do
        dZ[i] = dZ[i] / Z
    end

    return Psis, dZ
end

function PrintHamiltonianAnalysis(Psis, Operators, dZ, Header, Footer)
    io.write(Header)
    for i, Psi in ipairs(Psis) do
        io.write(string.format("%5d", i))
        for j, operator in ipairs(Operators) do
            if j == 1 then
                io.write(string.format("%12.6f", Complex.Re(Psi * operator * Psi)))
            elseif operator == "dZ" then
                io.write(string.format("%12.2e", dZ[i]))
            else
                io.write(string.format("%10.4f", Complex.Re(Psi * operator * Psi)))
            end
        end
        io.write("\n")
    end
    io.write(Footer)
end

--------------------------------------------------------------------------------
-- Define the restrictions and set the number of initial states.
--------------------------------------------------------------------------------
InitialRestrictions = {NFermions, NBosons, {"111111 0000000000", NElectrons_2p, NElectrons_2p},
                                           {"000000 1111111111", NElectrons_5d, NElectrons_5d}}

FinalRestrictions = {NFermions, NBosons, {"111111 0000000000", NElectrons_2p - 1, NElectrons_2p - 1},
                                         {"000000 1111111111", NElectrons_5d + 1, NElectrons_5d + 1}}

CalculationRestrictions = nil

--------------------------------------------------------------------------------
-- Analyze the initial Hamiltonian.
--------------------------------------------------------------------------------
Temperature = Temperature * EnergyUnits.Kelvin.value

Sk = DotProduct(WaveVector, {Sx, Sy, Sz})
Lk = DotProduct(WaveVector, {Lx, Ly, Lz})
Jk = DotProduct(WaveVector, {Jx, Jy, Jz})
Tk = DotProduct(WaveVector, {Tx, Ty, Tz})

Operators = {H_i, Ssqr, Lsqr, Jsqr, Sk, Lk, Jk, Tk, ldots_5d, N_2p, N_5d, "dZ"}
Header = "Analysis of the %s Hamiltonian:\n"
Header = Header .. "=================================================================================================================================\n"
Header = Header .. "State           E     <S^2>     <L^2>     <J^2>      <Sk>      <Lk>      <Jk>      <Tk>     <l.s>    <N_2p>    <N_5d>          dZ\n"
Header = Header .. "=================================================================================================================================\n"
Footer = "=================================================================================================================================\n\n"

local Psis_i, dZ_i = WavefunctionsAndBoltzmannFactors(H_i, NPsis, NPsisAuto, Temperature, nil, InitialRestrictions, CalculationRestrictions)
PrintHamiltonianAnalysis(Psis_i, Operators, dZ_i, string.format(Header, "initial"), Footer)

-- Stop the calculation if no spectra need to be calculated.
if next(SpectraToCalculate) == nil then
    return
end

--------------------------------------------------------------------------------
-- Calculate and save the spectra.
--------------------------------------------------------------------------------
local t = math.sqrt(1 / 2)

Tx_2p_5d = NewOperator("CF", NFermions, IndexUp_5d, IndexDn_5d, IndexUp_2p, IndexDn_2p, {{1, -1, t}, {1, 1, -t}})
Ty_2p_5d = NewOperator("CF", NFermions, IndexUp_5d, IndexDn_5d, IndexUp_2p, IndexDn_2p, {{1, -1, t * I}, {1, 1, t * I}})
Tz_2p_5d = NewOperator("CF", NFermions, IndexUp_5d, IndexDn_5d, IndexUp_2p, IndexDn_2p, {{1, 0, 1}})

Er = {t * (Eh[1] - I * Ev[1]),
      t * (Eh[2] - I * Ev[2]),
      t * (Eh[3] - I * Ev[3])}

El = {-t * (Eh[1] + I * Ev[1]),
      -t * (Eh[2] + I * Ev[2]),
      -t * (Eh[3] + I * Ev[3])}

Tv_2p_5d = DotProduct(Ev, {Tx_2p_5d, Ty_2p_5d, Tz_2p_5d})
Th_2p_5d = DotProduct(Eh, {Tx_2p_5d, Ty_2p_5d, Tz_2p_5d})
Tr_2p_5d = DotProduct(Er, {Tx_2p_5d, Ty_2p_5d, Tz_2p_5d})
Tl_2p_5d = DotProduct(El, {Tx_2p_5d, Ty_2p_5d, Tz_2p_5d})
Tk_2p_5d = DotProduct(WaveVector, {Tx_2p_5d, Ty_2p_5d, Tz_2p_5d})

-- Initialize a table with the available spectra and the required operators.
SpectraAndOperators = {
    ["Isotropic Absorption"] = {Tk_2p_5d, Tr_2p_5d, Tl_2p_5d},
    ["Absorption"] = {Tk_2p_5d,},
    ["Circular Dichroic"] = {Tr_2p_5d, Tl_2p_5d},
    ["Linear Dichroic"] = {Tv_2p_5d, Th_2p_5d},
}

-- Create an unordered set with the required operators.
local T_2p_5d = {}
for Spectrum, Operators in pairs(SpectraAndOperators) do
    if ValueInTable(Spectrum, SpectraToCalculate) then
        for _, Operator in pairs(Operators) do
            T_2p_5d[Operator] = true
        end
    end
end

-- Give the operators table the form required by Quanty's functions.
local T = {}
for Operator, _ in pairs(T_2p_5d) do
    table.insert(T, Operator)
end
T_2p_5d = T

Emin = Emin - (ZeroShift + ExperimentalShift)
Emax = Emax - (ZeroShift + ExperimentalShift)

if CalculationRestrictions == nil then
    G_2p_5d = CreateSpectra(H_f, T_2p_5d, Psis_i, {{"Emin", Emin}, {"Emax", Emax}, {"NE", NPoints}, {"Gamma", Gamma}, {"DenseBorder", DenseBorder}})
else
    G_2p_5d = CreateSpectra(H_f, T_2p_5d, Psis_i, {{"Emin", Emin}, {"Emax", Emax}, {"NE", NPoints}, {"Gamma", Gamma}, {"Restrictions", CalculationRestrictions}, {"DenseBorder", DenseBorder}})
end

-- Shift the calculated spectra.
G_2p_5d.Shift(ZeroShift + ExperimentalShift)

-- Create a list with the Boltzmann probabilities for a given operator and wavefunction.
local dZ_2p_5d = {}
for _ in ipairs(T_2p_5d) do
    for j in ipairs(Psis_i) do
        table.insert(dZ_2p_5d, dZ_i[j])
    end
end

local Ids = {}
for k, v in pairs(T_2p_5d) do
    Ids[v] = k
end

-- Subtract the broadening used in the spectra calculations from the Lorentzian table.
for i, _ in ipairs(Lorentzian) do
    -- The FWHM is the second value in each pair.
    Lorentzian[i][2] = Lorentzian[i][2] - Gamma
end

Pcl_2p_5d = 2

for Spectrum, Operators in pairs(SpectraAndOperators) do
    if ValueInTable(Spectrum, SpectraToCalculate) then
        -- Find the indices of the spectrum's operators in the table used during the
        -- calculation (this is unsorted).
        SpectrumIds = {}
        for _, Operator in pairs(Operators) do
            table.insert(SpectrumIds, Ids[Operator])
        end

        if Spectrum == "Isotropic Absorption" then
            Giso = GetSpectrum(G_2p_5d, SpectrumIds, dZ_2p_5d, #T_2p_5d, #Psis_i)
            Giso = Giso / 3
            SaveSpectrum(Giso, Prefix .. "_iso", Gaussian, Lorentzian, Pcl_2p_5d)
        end

        if Spectrum == "Absorption" then
            Gk = GetSpectrum(G_2p_5d, SpectrumIds, dZ_2p_5d, #T_2p_5d, #Psis_i)
            SaveSpectrum(Gk, Prefix .. "_k", Gaussian, Lorentzian, Pcl_2p_5d)
        end

        if Spectrum == "Circular Dichroic" then
            Gr = GetSpectrum(G_2p_5d, SpectrumIds[1], dZ_2p_5d, #T_2p_5d, #Psis_i)
            Gl = GetSpectrum(G_2p_5d, SpectrumIds[2], dZ_2p_5d, #T_2p_5d, #Psis_i)
            SaveSpectrum(Gr, Prefix .. "_r", Gaussian, Lorentzian, Pcl_2p_5d)
            SaveSpectrum(Gl, Prefix .. "_l", Gaussian, Lorentzian, Pcl_2p_5d)
            SaveSpectrum(Gr - Gl, Prefix .. "_cd", Gaussian, Lorentzian, 1)
        end

        if Spectrum == "Linear Dichroic" then
            Gv = GetSpectrum(G_2p_5d, SpectrumIds[1], dZ_2p_5d, #T_2p_5d, #Psis_i)
            Gh = GetSpectrum(G_2p_5d, SpectrumIds[2], dZ_2p_5d, #T_2p_5d, #Psis_i)
            SaveSpectrum(Gv, Prefix .. "_v", Gaussian, Lorentzian, Pcl_2p_5d)
            SaveSpectrum(Gh, Prefix .. "_h", Gaussian, Lorentzian, Pcl_2p_5d)
            SaveSpectrum(Gv - Gh, Prefix .. "_ld", Gaussian, Lorentzian, 1)
        end
    end
end
