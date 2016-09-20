--------------------------------------------------------------------------------
-- Quanty input file generated using Crispy.
--
-- elements: 3d transition metals
-- symmetry: Oh
-- experiment: XAS
-- edge: K (3s)
-- Hamiltonian: Coulomb, spin-orbit coupling, ligand field
-- transition operators: dipole
-- date: 16/09/2016
--------------------------------------------------------------------------------
Verbosity(0x00FF)

--------------------------------------------------------------------------------
-- Define the number of electrons, shells, etc.
--------------------------------------------------------------------------------
NBosons = 0
NFermions = 22

NElectrons_3s = $NElectrons_3s
NElectrons_3d = $NElectrons_3d
NElectrons_Ld = 10

IndexDn_3s = {0}
IndexUp_3s = {1}
IndexDn_3d = {2, 4, 6, 8, 10}
IndexUp_3d = {3, 5, 7, 9, 11}
IndexDn_Ld = {12, 14, 16, 18, 20}
IndexUp_Ld = {13, 15, 17, 19, 21}

--------------------------------------------------------------------------------
-- Define the Coulomb term.
--------------------------------------------------------------------------------
OppF0_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {1, 0, 0})
OppF2_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 1, 0})
OppF4_3d_3d = NewOperator('U', NFermions, IndexUp_3d, IndexDn_3d, {0, 0, 1})

OppF0_3s_3d = NewOperator('U', NFermions, IndexUp_3s, IndexDn_3s, IndexUp_3d, IndexDn_3d, {1}, {0})
OppG2_3s_3d = NewOperator('U', NFermions, IndexUp_3s, IndexDn_3s, IndexUp_3d, IndexDn_3d, {0}, {1})

OppNUp_3s = NewOperator('Number', NFermions, IndexUp_3s, IndexUp_3s, {1})
OppNDn_3s = NewOperator('Number', NFermions, IndexDn_3s, IndexDn_3s, {1})
OppN_3s   = OppNUp_3s + OppNDn_3s

OppNUp_3d = NewOperator('Number', NFermions, IndexUp_3d, IndexUp_3d, {1, 1, 1, 1, 1})
OppNDn_3d = NewOperator('Number', NFermions, IndexDn_3d, IndexDn_3d, {1, 1, 1, 1, 1})
OppN_3d   = OppNUp_3d + OppNDn_3d

OppNUp_Ld = NewOperator('Number', NFermions, IndexUp_Ld, IndexUp_Ld, {1, 1, 1, 1, 1})
OppNDn_Ld = NewOperator('Number', NFermions, IndexDn_Ld, IndexDn_Ld, {1, 1, 1, 1, 1})
OppN_Ld   = OppNUp_Ld + OppNDn_Ld

Delta_sc    = $Delta_sc
U_3d_3d_sc  = $U(3d,3d)_sc
F2_3d_3d_sc = $F2(3d,3d)_sc
F4_3d_3d_sc = $F4(3d,3d)_sc
F0_3d_3d_sc = U_3d_3d_sc + 2 / 63 * F2_3d_3d_sc + 2 / 63 * F4_3d_3d_sc
e_3d_sc     = (10 * Delta_sc - NElectrons_3d * (19 + NElectrons_3d) * U_3d_3d_sc / 2) / (10 + NElectrons_3d)
e_Ld_sc     = NElectrons_3d * ((1 + NElectrons_3d) * U_3d_3d_sc / 2 - Delta_sc) / (10 + NElectrons_3d)

Delta_fc    = $Delta_fc
U_3d_3d_fc  = $U(3d,3d)_fc
F2_3d_3d_fc = $F2(3d,3d)_fc
F4_3d_3d_fc = $F4(3d,3d)_fc
F0_3d_3d_fc = U_3d_3d_fc + 2 / 63 * F2_3d_3d_fc + 2 / 63 * F4_3d_3d_fc
U_3s_3d_fc  = $U(3s,3d)_fc
G2_3s_3d_fc = $G2(3s,3d)_fc
F0_3s_3d_fc = U_3s_3d_fc + 1 / 10 * G2_3s_3d_fc
e_3s_fc = (10 * Delta_fc + (1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_fc / 2 - (10 + NElectrons_3d) * U_3s_3d_fc)) / (12 + NElectrons_3d)
e_3d_fc = (10 * Delta_fc - NElectrons_3d * (23 + NElectrons_3d) * U_3d_3d_fc / 2 - 22 * U_3s_3d_fc) / (12 + NElectrons_3d)
e_Ld_fc = ((1 + NElectrons_3d) * (NElectrons_3d * U_3d_3d_fc / 2 + 2 * U_3s_3d_fc) - (2 + NElectrons_3d) * Delta_fc) / (12 + NElectrons_3d)

H_coulomb_sc = F0_3d_3d_sc * OppF0_3d_3d
             + F2_3d_3d_sc * OppF2_3d_3d
             + F4_3d_3d_sc * OppF4_3d_3d
             + e_3d_sc     * OppN_3d
             + e_Ld_sc     * OppN_Ld

H_coulomb_fc = F0_3d_3d_fc * OppF0_3d_3d
             + F2_3d_3d_fc * OppF2_3d_3d
             + F4_3d_3d_fc * OppF4_3d_3d
             + F0_3s_3d_fc * OppF0_3s_3d
             + G2_3s_3d_fc * OppG2_3s_3d
             + e_3s_fc     * OppN_3s
             + e_3d_fc     * OppN_3d
             + e_Ld_fc     * OppN_Ld

--------------------------------------------------------------------------------
-- Define the spin-orbit coupling term.
--------------------------------------------------------------------------------
Oppldots_3d = NewOperator('ldots', NFermions, IndexUp_3d, IndexDn_3d)

zeta_3d_sc = $zeta(3d)_sc

zeta_3d_fc = $zeta(3d)_fc

H_soc_sc = zeta_3d_sc * Oppldots_3d

H_soc_fc = zeta_3d_fc * Oppldots_3d

--------------------------------------------------------------------------------
-- Define the ligand field term.
--------------------------------------------------------------------------------
OpptenDq_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {0.6, -0.4}))
OpptenDq_Ld = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('Oh', 2, {0.6, -0.4}))

OppVeg_3d = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {1, 0}))
OppVeg_Ld = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('Oh', 2, {1, 0}))
OppVeg = OppVeg_3d + OppVeg_Ld

OppVt2g_3d = NewOperator('CF', NFermions, IndexUp_Ld, IndexDn_Ld, IndexUp_3d, IndexDn_3d, PotentialExpandedOnClm('Oh', 2, {0, 1}))
OppVt2g_Ld = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_Ld, IndexDn_Ld, PotentialExpandedOnClm('Oh', 2, {0, 1}))
OppVt2g = OppVt2g_3d + OppVt2g_Ld

tenDq_3d_sc = $10Dq(3d)_sc
tenDq_Ld_sc = $10Dq(Ld)_sc
Veg_sc      = $V(eg)_sc
Vt2g_sc     = $V(t2g)_sc

tenDq_3d_fc = $10Dq(3d)_fc
tenDq_Ld_fc = $10Dq(Ld)_fc
Veg_fc      = $V(eg)_fc
Vt2g_fc     = $V(t2g)_fc

H_lf_sc = tenDq_3d_sc * OpptenDq_3d
        + tenDq_Ld_sc * OpptenDq_Ld
        + Veg_sc      * OppVeg
        + Vt2g_sc     * OppVt2g

H_lf_fc = tenDq_3d_fc * OpptenDq_3d
        + tenDq_Ld_fc * OpptenDq_Ld
        + Veg_fc      * OppVeg
        + Vt2g_fc     * OppVt2g

--------------------------------------------------------------------------------
-- Define the magnetic field term.
--------------------------------------------------------------------------------
OppSx_3d    = NewOperator('Sx'   , NFermions, IndexUp_3d, IndexDn_3d)
OppSy_3d    = NewOperator('Sy'   , NFermions, IndexUp_3d, IndexDn_3d)
OppSz_3d    = NewOperator('Sz'   , NFermions, IndexUp_3d, IndexDn_3d)
OppSsqr_3d  = NewOperator('Ssqr' , NFermions, IndexUp_3d, IndexDn_3d)
OppSplus_3d = NewOperator('Splus', NFermions, IndexUp_3d, IndexDn_3d)
OppSmin_3d  = NewOperator('Smin' , NFermions, IndexUp_3d, IndexDn_3d)

OppLx_3d    = NewOperator('Lx'   , NFermions, IndexUp_3d, IndexDn_3d)
OppLy_3d    = NewOperator('Ly'   , NFermions, IndexUp_3d, IndexDn_3d)
OppLz_3d    = NewOperator('Lz'   , NFermions, IndexUp_3d, IndexDn_3d)
OppLsqr_3d  = NewOperator('Lsqr' , NFermions, IndexUp_3d, IndexDn_3d)
OppLplus_3d = NewOperator('Lplus', NFermions, IndexUp_3d, IndexDn_3d)
OppLmin_3d  = NewOperator('Lmin' , NFermions, IndexUp_3d, IndexDn_3d)

OppJx_3d    = NewOperator('Jx'   , NFermions, IndexUp_3d, IndexDn_3d)
OppJy_3d    = NewOperator('Jy'   , NFermions, IndexUp_3d, IndexDn_3d)
OppJz_3d    = NewOperator('Jz'   , NFermions, IndexUp_3d, IndexDn_3d)
OppJsqr_3d  = NewOperator('Jsqr' , NFermions, IndexUp_3d, IndexDn_3d)
OppJplus_3d = NewOperator('Jplus', NFermions, IndexUp_3d, IndexDn_3d)
OppJmin_3d  = NewOperator('Jmin' , NFermions, IndexUp_3d, IndexDn_3d)

OppSx_Ld    = NewOperator('Sx'   , NFermions, IndexUp_Ld, IndexDn_Ld)
OppSy_Ld    = NewOperator('Sy'   , NFermions, IndexUp_Ld, IndexDn_Ld)
OppSz_Ld    = NewOperator('Sz'   , NFermions, IndexUp_Ld, IndexDn_Ld)
OppSsqr_Ld  = NewOperator('Ssqr' , NFermions, IndexUp_Ld, IndexDn_Ld)
OppSplus_Ld = NewOperator('Splus', NFermions, IndexUp_Ld, IndexDn_Ld)
OppSmin_Ld  = NewOperator('Smin' , NFermions, IndexUp_Ld, IndexDn_Ld)

OppLx_Ld    = NewOperator('Lx'   , NFermions, IndexUp_Ld, IndexDn_Ld)
OppLy_Ld    = NewOperator('Ly'   , NFermions, IndexUp_Ld, IndexDn_Ld)
OppLz_Ld    = NewOperator('Lz'   , NFermions, IndexUp_Ld, IndexDn_Ld)
OppLsqr_Ld  = NewOperator('Lsqr' , NFermions, IndexUp_Ld, IndexDn_Ld)
OppLplus_Ld = NewOperator('Lplus', NFermions, IndexUp_Ld, IndexDn_Ld)
OppLmin_Ld  = NewOperator('Lmin' , NFermions, IndexUp_Ld, IndexDn_Ld)

OppJx_Ld    = NewOperator('Jx'   , NFermions, IndexUp_Ld, IndexDn_Ld)
OppJy_Ld    = NewOperator('Jy'   , NFermions, IndexUp_Ld, IndexDn_Ld)
OppJz_Ld    = NewOperator('Jz'   , NFermions, IndexUp_Ld, IndexDn_Ld)
OppJsqr_Ld  = NewOperator('Jsqr' , NFermions, IndexUp_Ld, IndexDn_Ld)
OppJplus_Ld = NewOperator('Jplus', NFermions, IndexUp_Ld, IndexDn_Ld)
OppJmin_Ld  = NewOperator('Jmin' , NFermions, IndexUp_Ld, IndexDn_Ld)

OppSx   = OppSx_3d + OppSx_Ld
OppSy   = OppSy_3d + OppSy_Ld
OppSz   = OppSz_3d + OppSz_Ld
OppSsqr = OppSx * OppSx + OppSy * OppSy + OppSz * OppSz

OppLx   = OppLx_3d + OppLx_Ld
OppLy   = OppLy_3d + OppLy_Ld
OppLz   = OppLz_3d + OppLz_Ld
OppLsqr = OppLx * OppLx + OppLy * OppLy + OppLz * OppLz

OppJx   = OppJx_3d + OppJx_Ld
OppJy   = OppJy_3d + OppJy_Ld
OppJz   = OppJz_3d + OppJz_Ld
OppJsqr = OppJx * OppJx + OppJy * OppJy + OppJz * OppJz

Bx =  0.0 * EnergyUnits.Tesla.value
By =  0.0 * EnergyUnits.Tesla.value
Bz = 1e-6 * EnergyUnits.Tesla.value

B = Bx * (2 * OppSx + OppLx)
  + By * (2 * OppSy + OppLy)
  + Bz * (2 * OppSz + OppLz)

--------------------------------------------------------------------------------
-- Compose the total Hamiltonian.
--------------------------------------------------------------------------------
H_sc = $H_coulomb_flag * H_coulomb_sc + $H_soc_flag * H_soc_sc + $H_lf_flag * H_lf_sc + B
H_fc = $H_coulomb_flag * H_coulomb_fc + $H_soc_flag * H_soc_fc + $H_lf_flag * H_lf_fc + B

--------------------------------------------------------------------------------
-- Determine the maximum number of states and define the starting restrictions.
--------------------------------------------------------------------------------
NPsis = 16

StartingRestrictions = {NFermions, NBosons, {'11 0000000000 0000000000', NElectrons_3s, NElectrons_3s},
                                            {'00 1111111111 0000000000', NElectrons_3d, NElectrons_3d},
                                            {'00 0000000000 1111111111', NElectrons_Ld, NElectrons_Ld}}

Psis = Eigensystem(H_sc, StartingRestrictions, NPsis)
if not (type(Psis) == 'table') then
    Psis = {Psis}
end

-- Print some useful information about the calculated states.
OppList = {H_sc, OppSsqr, OppLsqr, OppJsqr, OppSz, OppLz, OppN_3s, OppN_3d, OppN_Ld}

print('     <E>    <S^2>    <L^2>    <J^2>    <Sz>     <Lz>     <Np>      <Nd>     <NL>');
for key, Psi in pairs(Psis) do
	expectationValues = Psi * OppList * Psi
	for key, expectationValue in pairs(expectationValues) do
		io.write(string.format('%9.4f', Complex.Re(expectationValue)))
	end
	io.write('\n')
end

--------------------------------------------------------------------------------
-- Define the transition operator.
--------------------------------------------------------------------------------
t = math.sqrt(1/2);

OppTxy_3s_3d   = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2, -2, t * I}, {2, 2, -t * I}})
OppTxz_3s_3d   = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2, -1, t    }, {2, 1, -t    }})
OppTyz_3s_3d   = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2, -1, t * I}, {2, 1,  t * I}})
OppTx2y2_3s_3d = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2, -2, t    }, {2, 2,  t    }})
OppTz2_3s_3d   = NewOperator('CF', NFermions, IndexUp_3d, IndexDn_3d, IndexUp_3s, IndexDn_3s, {{2,  0, 1    }                })

--------------------------------------------------------------------------------
-- Calculate and save the spectra.
--------------------------------------------------------------------------------
-- Define the temperature.
T = $T * EnergyUnits.Kelvin.value

-- Initialize the partition function and the spectrum.
Z = 0
G = 0

Emin = $Emin1
Emax = $Emax1
Gamma = $Gamma1
NE = $NE1

-- Calculate the ground state energy.
E_gs = Psis[1] * H_sc * Psis[1]

for j = 1, NPsis do
    E_j = Psis[j] * H_sc * Psis[j]

    if math.abs(E_j - E_gs) < 1e-12 then
        dZ = 1
    else
        dZ = math.exp(-(E_j - E_gs) / T)
    end

    if (dZ < 1e-8) then
        break
    end

    Z = Z + dZ
    G = G + CreateSpectra(H_fc, {OppTxy_3s_3d, OppTxz_3s_3d, OppTyz_3s_3d, OppTx2y2_3s_3d, OppTz2_3s_3d}, Psis[j], {{'Emin', Emin}, {'Emax', Emax}, {'NE', NE}, {'Gamma', Gamma}}) * dZ
end

G = Spectra.Sum(G, {1, 1, 1, 1, 1}) / 5 / Z
G.Print({{'file', '$baseName' .. '.spec'}})