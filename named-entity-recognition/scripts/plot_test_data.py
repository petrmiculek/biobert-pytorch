import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.ticker as mtick
import seaborn as sns
from matplotlib.ticker import FuncFormatter
from matplotlib import rcParams

if __name__ == '__main__':

    df = pd.read_csv('all_test_results.csv', header=None, names=['dataset', 'model', 'f1', 'path'])
    df['model'] = df['model'].map({'bert-base-cased': 'BERT',
                                   'biobert-base-cased-v1.1': 'BioBERTv1.1',
                                   'biobert-base-cased-v1.2': 'BioBERTv1.2',
                                   })
    df['dataset'] = df['dataset'].map({'NCBI-disease': 'NCBI-\n-disease',
                                       'linnaeus': 'Linnaeus',
                                       's800': 'S800',
                                       'BC2GM': 'BC2GM',
                                       'JNLPBA': 'JNLPBA',
                                       'BC4CHEMD': 'BC4-\nCHEMD',
                                       'BC5CDR-chem': 'BC5CDR-\n-chem',
                                       })

    sns.set_theme(style="whitegrid")
    sns.set_context('poster')
    figure = plt.figure(figsize=(14, 6))
    figure.suptitle('Model comparison')

    gridspec = figure.add_gridspec(1, 1)
    ax = figure.add_subplot(gridspec[0, 0])
    figure.suptitle('F-1 Scores per Dataset Comparison')
    # sns.despine(bottom=True, left=True)
    ax.spines['right'].set_visible(False)
    ax.spines['top'].set_visible(False)
    ax.spines['left'].set_visible(False)
    ax.tick_params(which="both", bottom=True)

    datasets = df.groupby('dataset')
    avg_f1 = datasets['f1'].agg('mean').sort_values().index
    # avg_f1_idx =

    sns.barplot(x='dataset', y='f1', data=df, hue='model', order=avg_f1)
    ax.yaxis.set_major_formatter(mtick.PercentFormatter(1.0, decimals=0))
    ax.yaxis.grid(True, which='minor')
    ax.yaxis.set_minor_locator(mtick.MultipleLocator(5))

    plt.xlabel('')
    plt.ylabel('')
    plt.ylim(bottom=0.66, top=1.0)
    handles, labels = ax.get_legend_handles_labels()
    ax.get_legend().remove()

    figure.legend(handles, labels,
                  title="Model",
                  bbox_to_anchor=(0.10, 0.72),
                  loc="center left",
                  ncol=1
                  )
    figure.subplots_adjust(left=0.08, right=0.97, top=0.95, bottom=0.15)

    figure.savefig('poster-figure.svg')
    figure.show()
