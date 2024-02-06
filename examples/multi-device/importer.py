import importlib



def get_variables(*args):
    devices = {}

    for index, device in enumerate(args):
        device_module = import_file(device)
        devices[index] = device_module.DICT__device

    return {"DICT__DEVICES": devices}


def import_file(filename):
    spec = importlib.util.spec_from_file_location(filename, f"{filename}.py")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module