import pandas as pd 
import os

# Define the configuration path
current_path = os.path.dirname(os.path.abspath(__file__))
users_path = os.path.join(current_path, 'users.csv')
transactions_path = os.path.join(current_path, 'transactions.csv')

def load_csv(file_path: os) -> pd.DataFrame: 
    '''
    load_data: Get the CSV path file and create a df with the information on the file
    return: df
    '''
    try:
        df = pd.read_csv(file_path)
        return df
    except Exception as e:
        print("No possible to load the file, please ensure the path is OK")
        raise

def transform_users(users_df: pd.DataFrame) ->pd.DataFrame:
    '''
    transform_users: Convert email column to lower and define defaut email
    return: df
    '''
    users_df['email'] = users_df['email'].str.lower()
    users_df['email'] = users_df['email'].fillna('unknown@example.com')
    return users_df


def transform_transactions(transactions_df: pd.DataFrame)-> pd.DataFrame:
    '''
    transform_transactions: Convert timestamp column to datatime amd rename amount column
    return: df
    '''
    transactions_df['timestamp'] = pd.to_datetime(transactions_df['timestamp'])
    transactions_df.rename(columns={'amount': 'transaction_amount'}, inplace=True)
    return transactions_df

def merge_data(trans_df, users_df, join_on, join_type='join')->pd.DataFrame:
    '''
    merge_data: define joining, 2 df's, setup join on and join type
    return: df
    '''
    result_df = pd.merge(trans_df, users_df, how=join_type, on=join_on)
    return result_df

def main():
    # Load data
    users_df = load_csv(users_path)
    transactions_df = load_csv(transactions_path)
    
    # Transform data
    transactions_df = transform_transactions(transactions_df)
    users_df = transform_users(users_df)

    # Merge data
    result_df = merge_data(transactions_df, users_df, join_on='user_id', join_type='left')

    # Display the result
    print(result_df)

if __name__ == '__main__':
    main()