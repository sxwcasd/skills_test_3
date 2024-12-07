import pandas as pd

def merge_refs(filename_1,filename_2,filename_3):
    ref = pd.read_csv(filename_1, sep="\t")
    ref_2 = pd.read_csv(filename_2, sep="\t")
    ref_3 = pd.read_csv(filename_3, sep="\t")

    joined_df = ref.merge(ref_2, on='A', how='inner', suffixes=('_1', '_2')) 
    return joined_df
