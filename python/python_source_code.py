import pandas as pd 
import os

def load_csv(path) -> pd.DataFrame: 
    '''
    load_data: Get the CSV path file and create a df with the information on the path
    return: df
    '''
    df = pd.read_csv(path)
    # users_df = pd.read_csv('c:\csv\users.csv)
    #transactions_df = pd.read_csv(c:\csv\transactions.csv)
    return df

def transform_users(users_df: pd.DataFrame) ->pd.DataFrame:
    '''
    user_transformation: 
    return:
    '''
    users_df['email'] = users_df['email'].str.lower()
    users_df['email'].fillna('unknown@example.com', inplace=True)
    return users_df


def transform_transactions(transactions_df: pd.DataFrame)-> pd.DataFrame:
    '''
    '''
    transactions_df['timestamp'] = pd.to_datetime(transactions_df['timestamp'])
    transactions_df.rename(columns={'amount': 'transaction_amount'}, inplace=True)
    return transactions_df

def merge_data(trans_df, users_df, join_on, join_type='join')->pd.DataFrame:
    '''
    '''
    result_df = pd.merge(trans_df, users_df, how=join_type, on=join_on)
    return result_df

def main():
    # Display the result
    print(result_df)