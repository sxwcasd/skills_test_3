import numpy as np
import argparse
import pandas as pd
import matplotlib.pyplot as plt

#extract file rootname from path
def get_nameroot(filename):
    return str(filename.split('/')[-1].split('.')[0])

#reformat sample ancestries df and get ready to merge
def process_sample_pcs(filename):
    df = pd.read_csv(filename, sep="\t")
    df = df["IntendedSample"].to_frame().T
    df.columns = ["PC1","PC2","PC3","PC4"]
    df["sample_name"] = get_nameroot(filename)
    df["label"] = "Study"
    return df

# merge reference df with all sample ancestries
def connect_ancestry_ref(ancestries, ref):
    ref_df = pd.read_csv(ref, sep="\t", names=["sample_name","PC1","PC2","PC3","PC4","label"])
    sample_df_lst = [ref_df]
    for ancestry in ancestries:
        df = process_sample_pcs(ancestry)
        sample_df_lst.append(df)

    merged_df = pd.concat( sample_df_lst ).reset_index()
    merged_df.drop('index', axis=1, inplace=True)
    merged_df.to_csv("merged_pcs.tsv",sep="\t",index=False)
    return merged_df

#create color dict
def create_color_dict(df, labels):
    populations = np.unique(df[labels])
    colors = {label: color for color,label in zip(populations, ['red', 'blue', 'green', 'yellow', 'pink'])}
    colordict = dict(zip(populations, colors))
    colordict["Study"] = "black"
    df["Color"] = df[labels].apply(lambda x: colordict.get(x))
    return df

# Scatter plot function
def scatter_plot_pc(df, pc_x, pc_y, labels, figure_name):
    fig, ax = plt.subplots(figsize=(10, 10))
    populations = np.unique(df[labels])
    for pop in populations:
        if pop == "Study":
            marker = "^"
        else:
            marker = "."
        idx = df[labels] == pop
        ax.scatter(df[pc_x][idx], df[pc_y][idx], c=df["Color"][idx], marker=marker, label=pop)

    ax.set_title(figure_name)
    ax.legend()
    ax.set_xlabel(pc_x)
    ax.set_ylabel(pc_y)
    fig.savefig(figure_name+'.png')
    return fig

  
def scatter_plot_pc3d(df, pc_x, pc_y, pc_z, labels, figure_name):
    fig = plt.figure()

    ax = fig.add_subplot(projection='3d')
    populations = np.unique(df[labels])
    for pop in populations:
        if pop == "Study":
            marker = "^"
        else:
            marker = "."
        idx = df[labels] == pop
        ax.scatter(df[pc_x][idx], df[pc_y][idx], df[pc_z][idx], c=df["Color"][idx], marker=marker, label=pop)

    ax.set_title(figure_name)
    ax.set_xlabel(pc_x)
    ax.set_ylabel(pc_y)
    ax.set_zlabel(pc_z)
    fig.savefig(figure_name+'.png')
    return fig

def plot_graphs(ref,ancestry_list):
    # Main plotting
    merged_df = connect_ancestry_ref(ancestry_list, ref)
    colored_df = create_color_dict(merged_df, "label") 
    # PC1 vs PC2
    scatter_plot_pc(colored_df, "PC1", "PC2", "label", "PC1_vs_PC2")
    # PC2 vs PC3
    scatter_plot_pc(colored_df, "PC2", "PC3", "label", "PC2_vs_PC3")
    # PC3 vs PC4
    scatter_plot_pc(colored_df, "PC3", "PC4", "label", "PC3_vs_PC4")
    # PC1 vs PC2 vs PC3 (3D)
    scatter_plot_pc3d(colored_df, "PC1", "PC2", "PC3", "label", "PC1_vs_PC2_vs_PC3")
    
def main():
    parser = argparse.ArgumentParser(description="Process an array of files.")
    parser.add_argument("--ancestry_pcs", required=True, help="Comma-separated list of ancestry pcs path")
    parser.add_argument("--merged_refs", required=True, help="merged 1000 genome reference file")
    args = parser.parse_args()

    ancestry_list = args.ancestry_pcs.split(" ")
    ref = args.merged_refs
    plot_graphs(ref,ancestry_list)

if __name__ == "__main__":
    main()
