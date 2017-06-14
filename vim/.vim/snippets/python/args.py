import argparse
def get_args():
    """
    Get command line arguments via argparse.
    
    Returns:
        argparse.Namespace : command line args as attributes of an object.   
    """
    # Use class docstring for program description
    parser = argparse.ArgumentParser(
        description=__doc__
    )
    # Allow to specify options that conflict with each other.
    verbosity_group = parser.add_mutually_exclusive_group()  
    verbosity_group.add_argument("-v", "--verbose", action="store_true")
    verbosity_group.add_argument("-q", "--quiet", action="store_true")
    # Get command line arguments.
    parser.add_argument(
        "-!!str-arg!!",
        "--!!str-arg-long!!",
        type=str,
        help="!!str-arg help!!",
    )
    parser.add_argument(
        "-!!int-arg!!",
        "--!!int-arg-long!!",
        type=int,
        help="!!int-arg help!!",
    )
    parser.add_argument(
        '-!!n-arg!!',
        '--!!multiple-arguments!!',
        nargs="*",
        type=str,
        required=True,
        default=None,
        help="!!multiple argument help!!",
    )
    # Return all arguments to script in a namespace.
    return parser.parse_args()
