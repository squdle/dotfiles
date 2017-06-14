try:
    !!EAFP!!
except !!error!!Error:
    !!handle or re-raise!! 
except (!!Aerror!!Error, !!Berror!!Error) as error:
    !!handle multiple errors or re-raise!! 
else:
    !!do if no error!!
finally:
    !!always do!!
