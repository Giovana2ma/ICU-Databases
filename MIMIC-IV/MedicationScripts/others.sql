WITH abx AS (
    SELECT DISTINCT
        drug
        , route
        , CASE
            WHEN LOWER(drug) LIKE '%adoxa%' THEN 0
            WHEN LOWER(drug) LIKE '%ala-tet%' THEN 0
            WHEN LOWER(drug) LIKE '%alodox%' THEN 0
            WHEN LOWER(drug) LIKE '%amikacin%' THEN 0
            WHEN LOWER(drug) LIKE '%amikin%' THEN 0
            WHEN LOWER(drug) LIKE '%amoxicill%' THEN 0
            WHEN LOWER(drug) LIKE '%amphotericin%' THEN 0
            WHEN LOWER(drug) LIKE '%anidulafungin%' THEN 0
            WHEN LOWER(drug) LIKE '%ancef%' THEN 0
            WHEN LOWER(drug) LIKE '%clavulanate%' THEN 0
            WHEN LOWER(drug) LIKE '%ampicillin%' THEN 0
            WHEN LOWER(drug) LIKE '%augmentin%' THEN 0
            WHEN LOWER(drug) LIKE '%avelox%' THEN 0
            WHEN LOWER(drug) LIKE '%avidoxy%' THEN 0
            WHEN LOWER(drug) LIKE '%azactam%' THEN 0
            WHEN LOWER(drug) LIKE '%azithromycin%' THEN 0
            WHEN LOWER(drug) LIKE '%aztreonam%' THEN 0
            WHEN LOWER(drug) LIKE '%axetil%' THEN 0
            WHEN LOWER(drug) LIKE '%bactocill%' THEN 0
            WHEN LOWER(drug) LIKE '%bactrim%' THEN 0
            WHEN LOWER(drug) LIKE '%bactroban%' THEN 0
            WHEN LOWER(drug) LIKE '%bethkis%' THEN 0
            WHEN LOWER(drug) LIKE '%biaxin%' THEN 0
            WHEN LOWER(drug) LIKE '%bicillin l-a%' THEN 0
            WHEN LOWER(drug) LIKE '%cayston%' THEN 0
            WHEN LOWER(drug) LIKE '%cefazolin%' THEN 0
            WHEN LOWER(drug) LIKE '%cedax%' THEN 0
            WHEN LOWER(drug) LIKE '%cefoxitin%' THEN 0
            WHEN LOWER(drug) LIKE '%ceftazidime%' THEN 0
            WHEN LOWER(drug) LIKE '%cefaclor%' THEN 0
            WHEN LOWER(drug) LIKE '%cefadroxil%' THEN 0
            WHEN LOWER(drug) LIKE '%cefdinir%' THEN 0
            WHEN LOWER(drug) LIKE '%cefditoren%' THEN 0
            WHEN LOWER(drug) LIKE '%cefepime%' THEN 0
            WHEN LOWER(drug) LIKE '%cefotan%' THEN 0
            WHEN LOWER(drug) LIKE '%cefotetan%' THEN 0
            WHEN LOWER(drug) LIKE '%cefotaxime%' THEN 0
            WHEN LOWER(drug) LIKE '%ceftaroline%' THEN 0
            WHEN LOWER(drug) LIKE '%cefpodoxime%' THEN 0
            WHEN LOWER(drug) LIKE '%cefpirome%' THEN 0
            WHEN LOWER(drug) LIKE '%cefprozil%' THEN 0
            WHEN LOWER(drug) LIKE '%ceftibuten%' THEN 0
            WHEN LOWER(drug) LIKE '%ceftin%' THEN 0
            WHEN LOWER(drug) LIKE '%ceftriaxone%' THEN 0
            WHEN LOWER(drug) LIKE '%cefuroxime%' THEN 0
            WHEN LOWER(drug) LIKE '%cephalexin%' THEN 0
            WHEN LOWER(drug) LIKE '%cephalothin%' THEN 0
            WHEN LOWER(drug) LIKE '%cephapririn%' THEN 0
            WHEN LOWER(drug) LIKE '%chloramphenicol%' THEN 0
            WHEN LOWER(drug) LIKE '%cipro%' THEN 0
            WHEN LOWER(drug) LIKE '%ciprofloxacin%' THEN 0
            WHEN LOWER(drug) LIKE '%claforan%' THEN 0
            WHEN LOWER(drug) LIKE '%clarithromycin%' THEN 0
            WHEN LOWER(drug) LIKE '%cleocin%' THEN 0
            WHEN LOWER(drug) LIKE '%clindamycin%' THEN 0
            WHEN LOWER(drug) LIKE '%cubicin%' THEN 0
            WHEN LOWER(drug) LIKE '%dicloxacillin%' THEN 0
            WHEN LOWER(drug) LIKE '%dirithromycin%' THEN 0
            WHEN LOWER(drug) LIKE '%doryx%' THEN 0
            WHEN LOWER(drug) LIKE '%doxycy%' THEN 0
            WHEN LOWER(drug) LIKE '%duricef%' THEN 0
            WHEN LOWER(drug) LIKE '%dynacin%' THEN 0
            WHEN LOWER(drug) LIKE '%ery-tab%' THEN 0
            WHEN LOWER(drug) LIKE '%eryped%' THEN 0
            WHEN LOWER(drug) LIKE '%eryc%' THEN 0
            WHEN LOWER(drug) LIKE '%erythrocin%' THEN 0
            WHEN LOWER(drug) LIKE '%erythromycin%' THEN 0
            WHEN LOWER(drug) LIKE '%factive%' THEN 0
            WHEN LOWER(drug) LIKE '%flagyl%' THEN 0
            WHEN LOWER(drug) LIKE '%fortaz%' THEN 0
            WHEN LOWER(drug) LIKE '%furadantin%' THEN 0
            WHEN LOWER(drug) LIKE '%garamycin%' THEN 0
            WHEN LOWER(drug) LIKE '%gentamicin%' THEN 0
            WHEN LOWER(drug) LIKE '%kanamycin%' THEN 0
            WHEN LOWER(drug) LIKE '%keflex%' THEN 0
            WHEN LOWER(drug) LIKE '%kefzol%' THEN 0
            WHEN LOWER(drug) LIKE '%ketek%' THEN 0
            WHEN LOWER(drug) LIKE '%levaquin%' THEN 0
            WHEN LOWER(drug) LIKE '%levofloxacin%' THEN 0
            WHEN LOWER(drug) LIKE '%lincocin%' THEN 0
            WHEN LOWER(drug) LIKE '%linezolid%' THEN 0
            WHEN LOWER(drug) LIKE '%macrobid%' THEN 0
            WHEN LOWER(drug) LIKE '%macrodantin%' THEN 0
            WHEN LOWER(drug) LIKE '%maxipime%' THEN 0
            WHEN LOWER(drug) LIKE '%mefoxin%' THEN 0
            WHEN LOWER(drug) LIKE '%metronidazole%' THEN 0
            WHEN LOWER(drug) LIKE '%meropenem%' THEN 0
            WHEN LOWER(drug) LIKE '%methicillin%' THEN 0
            WHEN LOWER(drug) LIKE '%minocin%' THEN 0
            WHEN LOWER(drug) LIKE '%minocycline%' THEN 0
            WHEN LOWER(drug) LIKE '%monodox%' THEN 0
            WHEN LOWER(drug) LIKE '%monurol%' THEN 0
            WHEN LOWER(drug) LIKE '%morgidox%' THEN 0
            WHEN LOWER(drug) LIKE '%moxatag%' THEN 0
            WHEN LOWER(drug) LIKE '%moxifloxacin%' THEN 0
            WHEN LOWER(drug) LIKE '%mupirocin%' THEN 0
            WHEN LOWER(drug) LIKE '%myrac%' THEN 0
            WHEN LOWER(drug) LIKE '%nafcillin%' THEN 0
            WHEN LOWER(drug) LIKE '%neomycin%' THEN 0
            WHEN LOWER(drug) LIKE '%nicazel doxy 30%' THEN 0
            WHEN LOWER(drug) LIKE '%nitrofurantoin%' THEN 0
            WHEN LOWER(drug) LIKE '%norfloxacin%' THEN 0
            WHEN LOWER(drug) LIKE '%noroxin%' THEN 0
            WHEN LOWER(drug) LIKE '%ocudox%' THEN 0
            WHEN LOWER(drug) LIKE '%ofloxacin%' THEN 0
            WHEN LOWER(drug) LIKE '%omnicef%' THEN 0
            WHEN LOWER(drug) LIKE '%oracea%' THEN 0
            WHEN LOWER(drug) LIKE '%oraxyl%' THEN 0
            WHEN LOWER(drug) LIKE '%oxacillin%' THEN 0
            WHEN LOWER(drug) LIKE '%pc pen vk%' THEN 0
            WHEN LOWER(drug) LIKE '%pce dispertab%' THEN 0
            WHEN LOWER(drug) LIKE '%panixine%' THEN 0
            WHEN LOWER(drug) LIKE '%pediazole%' THEN 0
            WHEN LOWER(drug) LIKE '%penicillin%' THEN 0
            WHEN LOWER(drug) LIKE '%periostat%' THEN 0
            WHEN LOWER(drug) LIKE '%pfizerpen%' THEN 0
            WHEN LOWER(drug) LIKE '%piperacillin%' THEN 0
            WHEN LOWER(drug) LIKE '%tazobactam%' THEN 0
            WHEN LOWER(drug) LIKE '%primsol%' THEN 0
            WHEN LOWER(drug) LIKE '%proquin%' THEN 0
            WHEN LOWER(drug) LIKE '%raniclor%' THEN 0
            WHEN LOWER(drug) LIKE '%rifadin%' THEN 0
            WHEN LOWER(drug) LIKE '%rifampin%' THEN 0
            WHEN LOWER(drug) LIKE '%rocephin%' THEN 0
            WHEN LOWER(drug) LIKE '%smz-tmp%' THEN 0
            WHEN LOWER(drug) LIKE '%septra%' THEN 0
            WHEN LOWER(drug) LIKE '%septra ds%' THEN 0
            WHEN LOWER(drug) LIKE '%septra%' THEN 0
            WHEN LOWER(drug) LIKE '%solodyn%' THEN 0
            WHEN LOWER(drug) LIKE '%spectracef%' THEN 0
            WHEN LOWER(drug) LIKE '%streptomycin%' THEN 0
            WHEN LOWER(drug) LIKE '%sulfadiazine%' THEN 0
            WHEN LOWER(drug) LIKE '%sulfamethoxazole%' THEN 0
            WHEN LOWER(drug) LIKE '%trimethoprim%' THEN 0
            WHEN LOWER(drug) LIKE '%sulfatrim%' THEN 0
            WHEN LOWER(drug) LIKE '%sulfisoxazole%' THEN 0
            WHEN LOWER(drug) LIKE '%suprax%' THEN 0
            WHEN LOWER(drug) LIKE '%synercid%' THEN 0
            WHEN LOWER(drug) LIKE '%tazicef%' THEN 0
            WHEN LOWER(drug) LIKE '%tetracycline%' THEN 0
            WHEN LOWER(drug) LIKE '%timentin%' THEN 0
            WHEN LOWER(drug) LIKE '%tobramycin%' THEN 0
            WHEN LOWER(drug) LIKE '%trimethoprim%' THEN 0
            WHEN LOWER(drug) LIKE '%unasyn%' THEN 0
            WHEN LOWER(drug) LIKE '%vancocin%' THEN 0
            WHEN LOWER(drug) LIKE '%vancomycin%' THEN 0
            WHEN LOWER(drug) LIKE '%vantin%' THEN 0
            WHEN LOWER(drug) LIKE '%vibativ%' THEN 0
            WHEN LOWER(drug) LIKE '%vibra-tabs%' THEN 0
            WHEN LOWER(drug) LIKE '%vibramycin%' THEN 0
            WHEN LOWER(drug) LIKE '%zinacef%' THEN 0
            WHEN LOWER(drug) LIKE '%zithromax%' THEN 0
            WHEN LOWER(drug) LIKE '%zosyn%' THEN 0
            WHEN LOWER(drug) LIKE '%zyvox%' THEN 0
            WHEN LOWER(drug) LIKE  '%apixaban%' THEN 0
            WHEN LOWER(drug) LIKE  '%argatroban%' THEN 0
            WHEN LOWER(drug) LIKE  '%bivalirudin%' THEN 0
            WHEN LOWER(drug) LIKE  '%dabigatran%' THEN 0
            WHEN LOWER(drug) LIKE  '%dalteparin%' THEN 0
            WHEN LOWER(drug) LIKE  '%edoxaban%' THEN 0
            WHEN LOWER(drug) LIKE  '%enoxa%' THEN 0
            WHEN LOWER(drug) LIKE  '%fondaparin%' THEN 0
            WHEN LOWER(drug) LIKE  '%hepa%' THEN 0
            WHEN LOWER(drug) LIKE  '%lepirudin%' THEN 0
            WHEN LOWER(drug) LIKE  '%rivaroxaban%' THEN 0
            WHEN LOWER(drug) LIKE  '%warfarin%' THEN 0
            WHEN LOWER(drug) LIKE  '%aspi%' THEN 0
            WHEN LOWER(drug) LIKE  '%brilinta%' THEN 0
            WHEN LOWER(drug) LIKE  '%clopidogrel%' THEN 0
            WHEN LOWER(drug) LIKE  '%dipyridamole%' THEN 0
            WHEN LOWER(drug) LIKE  '%plavix%' THEN 0
            WHEN LOWER(drug) LIKE  '%prasugrel%' THEN 0
            WHEN LOWER(drug) LIKE  '%ticagrelor%' THEN 0
            WHEN LOWER(drug) LIKE '%chlorpr%' THEN 0
            WHEN LOWER(drug) LIKE '%droperidol%' THEN 0
            WHEN LOWER(drug) LIKE '%fluphenazine%' THEN 0
            WHEN LOWER(drug) LIKE '%halop%' THEN 0
            WHEN LOWER(drug) LIKE '%perphenazine%' THEN 0
            WHEN LOWER(drug) LIKE '%pimozide%' THEN 0
            WHEN LOWER(drug) LIKE '%proch%' THEN 0
            WHEN LOWER(drug) LIKE '%thiothixene%' THEN 0
            WHEN LOWER(drug) LIKE '%trifluoperazine%' THEN 0
            WHEN LOWER(drug) LIKE '%amoxapine%' THEN 0
            WHEN LOWER(drug) LIKE 'arip%' THEN 0
            WHEN LOWER(drug) LIKE '%asenapine%' THEN 0
            WHEN LOWER(drug) LIKE '%brexpiprazole%' THEN 0
            WHEN LOWER(drug) LIKE '%cariprazine%' THEN 0
            WHEN LOWER(drug) LIKE '%clozapine%' THEN 0
            WHEN LOWER(drug) LIKE '%iloperidone%' THEN 0
            WHEN LOWER(drug) LIKE '%lurasidone%' THEN 0
            WHEN LOWER(drug) LIKE '%olanz%' THEN 0
            WHEN LOWER(drug) LIKE '%paliperidone%' THEN 0
            WHEN LOWER(drug) LIKE '%quetiapin%' THEN 0
            WHEN LOWER(drug) LIKE '%risperidone%' THEN 0
            WHEN LOWER(drug) LIKE '%ziprasidone%' THEN 0
            WHEN LOWER(drug) LIKE  '%aciphex%' THEN 0 
            WHEN LOWER(drug) LIKE  '%dexilant%' THEN 0 
            WHEN LOWER(drug) LIKE  '%dexlansoprazole%' THEN 0 
            WHEN LOWER(drug) LIKE  '%esomeprazole%' THEN 0 
            WHEN LOWER(drug) LIKE  'lansoprazole%' THEN 0 
            WHEN LOWER(drug) LIKE  '%nexium%' THEN 0 
            WHEN LOWER(drug) LIKE  '%omeprazole%' THEN 0 
            WHEN LOWER(drug) LIKE  '%panto%' THEN 0 
            WHEN LOWER(drug) LIKE  '%prevacid%' THEN 0 
            WHEN LOWER(drug) LIKE  '%prilosec%' THEN 0 
            WHEN LOWER(drug) LIKE  '%protonix%' THEN 0 
            WHEN LOWER(drug) LIKE  '%rabeprazole%' THEN 0 
            WHEN LOWER(drug) LIKE  '%zegerid%' THEN 0 
            WHEN LOWER(drug) LIKE  '%advil%' THEN 0
            WHEN LOWER(drug) LIKE  '%aspi%' THEN 0
            WHEN LOWER(drug) LIKE  '%cannabidiol%' THEN 0
            WHEN LOWER(drug) LIKE  '%dexmedetomidine%' THEN 0
            WHEN LOWER(drug) LIKE  '%fentanyl%' THEN 0
            WHEN LOWER(drug) LIKE  '%gaba%' THEN 0
            WHEN LOWER(drug) LIKE  '%keta%' THEN 0
            WHEN LOWER(drug) LIKE  '%menthol%' THEN 0
            WHEN LOWER(drug) LIKE  '%meprobamate%' THEN 0
            WHEN LOWER(drug) LIKE  '%mexiletine%' THEN 0
            WHEN LOWER(drug) LIKE  '%oxytocin%' THEN 0
            WHEN LOWER(drug) LIKE  '%phenazopyridine%' THEN 0
            WHEN LOWER(drug) LIKE  '%pregaba%' THEN 0
            WHEN LOWER(drug) LIKE  '%trama%' THEN 0
            WHEN LOWER(drug) LIKE  '%ziconotide%' THEN 0
            WHEN LOWER(drug) LIKE  '%alprazolam%' THEN 0
            WHEN LOWER(drug) LIKE  '%ambien%' THEN 0
            WHEN LOWER(drug) LIKE  '%ativan%' THEN 0
            WHEN LOWER(drug) LIKE  '%benadryl%' THEN 0
            WHEN LOWER(drug) LIKE  '%chloral hydrate%' THEN 0
            WHEN LOWER(drug) LIKE  '%chlordiazepoxide%' THEN 0
            WHEN LOWER(drug) LIKE  '%clonazepam%' THEN 0
            WHEN LOWER(drug) LIKE  '%clorazepate%' THEN 0
            WHEN LOWER(drug) LIKE  '%dexmedetomidine%' THEN 0
            WHEN LOWER(drug) LIKE  '%diazepam%' THEN 0
            WHEN LOWER(drug) LIKE  '%diphenhydramine%' THEN 0
            WHEN LOWER(drug) LIKE  '%estazolam%' THEN 0
            WHEN LOWER(drug) LIKE  '%eszopiclone%' THEN 0
            WHEN LOWER(drug) LIKE  '%etomidate%' THEN 0
            WHEN LOWER(drug) LIKE  '%flurazepam%' THEN 0
            WHEN LOWER(drug) LIKE  '%Halcion%' THEN 0
            WHEN LOWER(drug) LIKE  '%klonopin%' THEN 0
            WHEN LOWER(drug) LIKE  'loraze%' THEN 0
            WHEN LOWER(drug) LIKE  '%lunesta%' THEN 0
            WHEN LOWER(drug) LIKE  '%mebaral%' THEN 0
            WHEN LOWER(drug) LIKE  '%mephobarbital%' THEN 0
            WHEN LOWER(drug) LIKE  '%meprobamate%' THEN 0
            WHEN LOWER(drug) LIKE  '%midazolam%' THEN 0
            WHEN LOWER(drug) LIKE  '%mysoline%' THEN 0
            WHEN LOWER(drug) LIKE  '%oxazepam%' THEN 0
            WHEN LOWER(drug) LIKE  '%primidone%' THEN 0
            WHEN LOWER(drug) LIKE  '%promethazine%' THEN 0
            WHEN LOWER(drug) LIKE  '%propofol%' THEN 0
            WHEN LOWER(drug) LIKE  '%ramelteon%' THEN 0
            WHEN LOWER(drug) LIKE  '%rozerem%' THEN 0
            WHEN LOWER(drug) LIKE  '%sonata%' THEN 0
            WHEN LOWER(drug) LIKE  '%temazep%' THEN 0
            WHEN LOWER(drug) LIKE  '%triazolam%' THEN 0
            WHEN LOWER(drug) LIKE  '%valium%' THEN 0
            WHEN LOWER(drug) LIKE  '%xanax%' THEN 0
            WHEN LOWER(drug) LIKE  '%zaleplon%' THEN 0
            WHEN LOWER(drug) LIKE  '%zolpidem%' THEN 0
            WHEN LOWER(drug) LIKE  '%adeno%' THEN 0
            WHEN LOWER(drug) LIKE  '%cilos%' THEN 0
            WHEN LOWER(drug) LIKE  '%diazoxide%' THEN 0
            WHEN LOWER(drug) LIKE  '%milrinone%' THEN 0
            WHEN LOWER(drug) LIKE  '%minoxidil%' THEN 0
            WHEN LOWER(drug) LIKE  '%papaverine%' THEN 0
            WHEN LOWER(drug) LIKE  '%pentoxifylline%' THEN 0
            WHEN LOWER(drug) LIKE  '%prazosin%' THEN 0
            WHEN LOWER(drug) LIKE  '%yohimbine%' THEN 0
            WHEN LOWER(drug) LIKE  '%inositol%' THEN 0
            WHEN LOWER(drug) LIKE  '%nitroprusside%' THEN 0
            WHEN LOWER(drug) LIKE  '%cisatra%'THEN 0
            WHEN LOWER(drug) LIKE  '%rocuronium%'THEN 0
            WHEN LOWER(drug) LIKE  '%Succinylcholine%'THEN 0
            WHEN LOWER(drug) LIKE  '%dobutamine%' THEN 0
            WHEN LOWER(drug) LIKE  '%dopamine%' THEN 0
            WHEN LOWER(drug) LIKE  '%epinephrine%' THEN 0
            WHEN LOWER(drug) LIKE  '%milrinone%' THEN 0
            WHEN LOWER(drug) LIKE  '%norepinephrine%' THEN 0
            WHEN LOWER(drug) LIKE  '%phenyleph%' THEN 0
            WHEN LOWER(drug) LIKE  '%vasopressin%' THEN 0
            
            ELSE 1
        END AS other
    FROM mimiciv_hosp.prescriptions
    -- excludes vials/syringe/normal saline, etc
    WHERE drug_type NOT IN ('BASE')
        -- we exclude routes via the eye, ears, or topically
        AND route NOT IN ('OU', 'OS', 'OD', 'AU', 'AS', 'AD', 'TP')
        AND LOWER(route) NOT LIKE '%ear%'
        AND LOWER(route) NOT LIKE '%eye%'
        -- we exclude certain types of others: topical creams,
        -- gels, desens, etc
        AND LOWER(drug) NOT LIKE '%cream%'
        AND LOWER(drug) NOT LIKE '%desensitization%'
        AND LOWER(drug) NOT LIKE '%ophth oint%'
        AND LOWER(drug) NOT LIKE '%gel%'
-- other routes not sure about...
-- for sure keep: ('IV','PO','PO/NG','ORAL', 'IV DRIP', 'IV BOLUS')
-- ? VT, PB, PR, PL, NS, NG, NEB, NAS, LOCK, J TUBE, IVT
-- ? IT, IRR, IP, IO, INHALATION, IN, IM
-- ? IJ, IH, G TUBE, DIALYS
-- ?? enemas??
)

SELECT pr.drug,
        COUNT(pr.drug) AS quantidade 
FROM mimiciv_hosp.prescriptions pr
-- inner join to subselect to only other prescriptions
INNER JOIN abx
    ON pr.drug = abx.drug
WHERE abx.other = 1
GROUP BY pr.drug
;