class FileUtils(object):
    """
    A Bunch of file utilities.
    """

    @staticmethod
    def read_lines_from_file(filename):
        f = open(filename)
        s = f.readlines()
        return s
