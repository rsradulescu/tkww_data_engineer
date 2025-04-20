users_df = pd.read_csv('c:\csv\users.csv')
transactions_df = pd.read_csv('c:\csv\transactions.csv')
                              
users_df['email'] = users_df['email'].str.lower()
transactions_df['timestamp'] = pd.to_datetime(transactions_df['timestamp'])
transactions_df.rename(columns={'amount': 'transaction_amount'},
inplace=True)
users_df['email'].fillna('unknown@example.com', inplace=True)
result_df = pd.merge(transactions_df, users_df, how='left', on='user_id')
# Display the result
print(result_df)