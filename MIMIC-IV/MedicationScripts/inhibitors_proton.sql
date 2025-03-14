WITH abx AS (
    SELECT DISTINCT
        drug
        , route
        , CASE
            WHEN LOWER(drug) LIKE  '%aciphex%' THEN 1 
            WHEN LOWER(drug) LIKE  '%dexilant%' THEN 1 
            WHEN LOWER(drug) LIKE  '%dexlansoprazole%' THEN 1 
            WHEN LOWER(drug) LIKE  '%esomeprazole%' THEN 1 
            WHEN LOWER(drug) LIKE  'lansoprazole%' THEN 1 
            WHEN LOWER(drug) LIKE  '%nexium%' THEN 1 
            WHEN LOWER(drug) LIKE  '%omeprazole%' THEN 1 
            WHEN LOWER(drug) LIKE  '%panto%' THEN 1 
            WHEN LOWER(drug) LIKE  '%prevacid%' THEN 1 
            WHEN LOWER(drug) LIKE  '%prilosec%' THEN 1 
            WHEN LOWER(drug) LIKE  '%protonix%' THEN 1 
            WHEN LOWER(drug) LIKE  '%rabeprazole%' THEN 1 
            WHEN LOWER(drug) LIKE  '%zegerid%' THEN 1 
            
            ELSE 0
        END AS inhibitor
    FROM `physionet-data.mimiciv_hosp.prescriptions`
    -- excludes vials/syringe/normal saline, etc
    WHERE drug_type NOT IN ('BASE')
        -- we exclude routes via the eye, ears, or topically
        AND route NOT IN ('OU', 'OS', 'OD', 'AU', 'AS', 'AD', 'TP')
        AND LOWER(route) NOT LIKE '%ear%'
        AND LOWER(route) NOT LIKE '%eye%'
        -- we exclude certain types of inhibitors: topical creams,
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
    , pr.drug AS inhibitor
    , pr.route
    , pr.starttime
    , pr.stoptime
FROM `physionet-data.mimiciv_hosp.prescriptions` pr
-- inner join to subselect to only inhibitor prescriptions
INNER JOIN abx
    ON pr.drug = abx.drug
        -- route is never NULL for inhibitors
        -- only ~4000 null rows in prescriptions total.
        AND pr.route = abx.route
-- add in stay_id as we use this table for sepsis-3
LEFT JOIN `physionet-data.mimiciv_icu.icustays` ie
    ON pr.hadm_id = ie.hadm_id
        AND pr.starttime >= ie.intime
        AND pr.starttime < ie.outtime
WHERE abx.inhibitor = 1
;