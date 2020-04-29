select 'f?p=&APP_ID.:6:'||:app_session||':::6:P6_PRODUCT_ID,P6_BRANCH:'||p.product_id||',27:' link, 
    p.product_name||' [$'||p.list_price||']' product,
    SUM(oi.quantity * oi.unit_price) sales,
    decode(nvl(dbms_lob.getlength(p.product_image),0),0,null,
        apex_util.get_blob_file_src('P6_PRODUCT_IMAGE',p.product_id)) product_image
from demo_order_items oi,
    demo_product_info p
where oi.product_id = p.product_id
group by p.product_id, p.product_name, p.list_price,
    decode(nvl(dbms_lob.getlength(p.product_image),0),0,null,
        apex_util.get_blob_file_src('P6_PRODUCT_IMAGE',p.product_id))
order by 3 desc, 1