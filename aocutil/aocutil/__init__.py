
def read_ints(name):
    """
    reads current input file and return all lines as ints
    """
    with open(name) as f:
        return [int(line) for line in f]
