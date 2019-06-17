FROM beyselein/py_correction_base_image

COPY entrypoint.sh /data/

ENTRYPOINT ["./entrypoint.sh"]