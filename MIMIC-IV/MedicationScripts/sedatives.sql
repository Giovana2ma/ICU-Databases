WITH abx AS (
    SELECT DISTINCT
        drug
        , route
        , CASE
            WHEN LOWER(drug) LIKE  '%alprazolam%' THEN 1
            WHEN LOWER(drug) LIKE  '%ambien%' THEN 1
            WHEN LOWER(drug) LIKE  '%ativan%' THEN 1
            WHEN LOWER(drug) LIKE  '%benadryl%' THEN 1
            WHEN LOWER(drug) LIKE  '%chloral hydrate%' THEN 1
            WHEN LOWER(drug) LIKE  '%chlordiazepoxide%' THEN 1
            WHEN LOWER(drug) LIKE  '%clonazepam%' THEN 1
            WHEN LOWER(drug) LIKE  '%clorazepate%' THEN 1
            WHEN LOWER(drug) LIKE  '%dexmedetomidine%' THEN 1
            WHEN LOWER(drug) LIKE  '%diazepam%' THEN 1
            WHEN LOWER(drug) LIKE  '%diphenhydramine%' THEN 1
            WHEN LOWER(drug) LIKE  '%estazolam%' THEN 1
            WHEN LOWER(drug) LIKE  '%eszopiclone%' THEN 1
            WHEN LOWER(drug) LIKE  '%etomidate%' THEN 1
            WHEN LOWER(drug) LIKE  '%flurazepam%' THEN 1
            WHEN LOWER(drug) LIKE  '%Halcion%' THEN 1
            WHEN LOWER(drug) LIKE  '%klonopin%' THEN 1
            WHEN LOWER(drug) LIKE  'loraze%' THEN 1
            WHEN LOWER(drug) LIKE  '%lunesta%' THEN 1
            WHEN LOWER(drug) LIKE  '%mebaral%' THEN 1
            WHEN LOWER(drug) LIKE  '%mephobarbital%' THEN 1
            WHEN LOWER(drug) LIKE  '%meprobamate%' THEN 1
            WHEN LOWER(drug) LIKE  '%midazolam%' THEN 1
            WHEN LOWER(drug) LIKE  '%mysoline%' THEN 1
            WHEN LOWER(drug) LIKE  '%oxazepam%' THEN 1
            WHEN LOWER(drug) LIKE  '%primidone%' THEN 1
            WHEN LOWER(drug) LIKE  '%promethazine%' THEN 1
            WHEN LOWER(drug) LIKE  '%propofol%' THEN 1
            WHEN LOWER(drug) LIKE  '%ramelteon%' THEN 1
            WHEN LOWER(drug) LIKE  '%rozerem%' THEN 1
            WHEN LOWER(drug) LIKE  '%sonata%' THEN 1
            WHEN LOWER(drug) LIKE  '%temazep%' THEN 1
            WHEN LOWER(drug) LIKE  '%triazolam%' THEN 1
            WHEN LOWER(drug) LIKE  '%valium%' THEN 1
            WHEN LOWER(drug) LIKE  '%xanax%' THEN 1
            WHEN LOWER(drug) LIKE  '%zaleplon%' THEN 1
            WHEN LOWER(drug) LIKE  '%zolpidem%' THEN 1
            
            ELSE 0
        END AS sedative
    FROM `physionet-data.mimiciv_hosp.prescriptions`
    -- excludes vials/syringe/normal saline, etc
    WHERE drug_type NOT IN ('BASE')
        -- we exclude routes via the eye, ears, or topically
        AND route NOT IN ('OU', 'OS', 'OD', 'AU', 'AS', 'AD', 'TP')
        AND LOWER(route) NOT LIKE '%ear%'
        AND LOWER(route) NOT LIKE '%eye%'
        -- we exclude certain types of sedatives: topical creams,
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

SELECT
    pr.subject_id, pr.hadm_id
    , ie.stay_id
    , pr.drug AS sedative
    , pr.route
    , pr.starttime
    , pr.stoptime
FROM `physionet-data.mimiciv_hosp.prescriptions` pr
-- inner join to subselect to only sedative prescriptions
INNER JOIN abx
    ON pr.drug = abx.drug
        -- route is never NULL for sedatives
        -- only ~4000 null rows in prescriptions total.
        AND pr.route = abx.route
-- add in stay_id as we use this table for sepsis-3
LEFT JOIN `physionet-data.mimiciv_icu.icustays` ie
    ON pr.hadm_id = ie.hadm_id
        AND pr.starttime >= ie.intime
        AND pr.starttime < ie.outtime
WHERE abx.sedative = 1
;