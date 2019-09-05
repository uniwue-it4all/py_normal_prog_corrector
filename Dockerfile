FROM beyselein/py_correction_base_image

COPY entrypoint.sh perform_lints.py files_to_lint.txt /data/

ENTRYPOINT ["./entrypoint.sh"]