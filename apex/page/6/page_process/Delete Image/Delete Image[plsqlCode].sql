-- empty the image
update demo_product_info 
set product_image = null,
mimetype = null,
filename=null,
image_last_update=null
where product_id = :P6_PRODUCT_ID;