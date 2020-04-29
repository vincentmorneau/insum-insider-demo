select aa.version app_version,
       to_char(aa.pages,'999G999G990') pages,
       'Oracle' vendor
from apex_applications aa
where aa.application_id = :APP_ID