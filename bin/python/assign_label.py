import pandas as pd
import argparse
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score

def study_train_split(df):
    train_test_df = df[df["label"] != "Study"]
    study_df = df[df["label"] == "Study"]
    return train_test_df, study_df

def load_df(df_file):
    merged_pc = pd.read_csv(df_file, sep="\t")
    return merged_pc

def format_label(df):
    df.columns=["SAMPLE","PC1","PC2","PC3","PC4","POPULATION"]
    df.to_csv("Populations.txt",sep="\t", index=False)

#function to perform random forest classifier to predict the label base on PCs
def assign_label(df_file):
    merged_pc = load_df(df_file)
    train_test_df, study_df = study_train_split(merged_pc)
    x = train_test_df.loc[:, train_test_df.columns.str.startswith("PC")]   
    y = train_test_df["label"]
    x_train, x_test, y_train, y_test = train_test_split(x, y, test_size=0.3)
    rf = RandomForestClassifier()
    rf.fit(x_train, y_train)
    y_pred = rf.predict(x_test)
    accuracy = accuracy_score(y_test, y_pred)
    print(f"Accuracy on test data: {accuracy}")

    predicted_label = rf.predict(study_df.loc[:, study_df.columns.str.startswith("PC")])
    print(predicted_label)

    study_df.loc[:,'label'] = predicted_label
    format_label(study_df)

def main():
    parser = argparse.ArgumentParser(description="Process an array of files.")
    parser.add_argument("--merged_df", required=True, help="merged 1000 genome reference file with ancestries")
    args = parser.parse_args()

    df_file = args.merged_df
    assign_label(df_file)

if __name__ == "__main__":
    main()
