from starlette.responses import JSONResponse


def circuitbreaker_call(circuitbreaker, data):
    if circuitbreaker.current_state == 'open':
        data = JSONResponse(status_code=404, content={"Error": "Oops, something went wrong. Try again in 10 seconds"})
    return data