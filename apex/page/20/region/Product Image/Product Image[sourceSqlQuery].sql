select decode(nvl(dbms_lob.getlength(product_image),0),0,null,'<img src="'||apex_util.get_blob_file_src('P6_PRODUCT_IMAGE',product_id)||'" />') image
from demo_product_info
where product_id = :P20_PRODUCT_ID
order by 1