UPDATE telco_customers
SET TotalCharges = NULL
WHERE tenure = 0;


UPDATE telco_customers
SET 
    customerID = REPLACE(customerID, '\r', ''),
    gender = REPLACE(gender, '\r', ''),
    Partner = REPLACE(Partner, '\r', ''),
    Dependents = REPLACE(Dependents, '\r', ''),
    PhoneService = REPLACE(PhoneService, '\r', ''),
    MultipleLines = REPLACE(MultipleLines, '\r', ''),
    InternetService = REPLACE(InternetService, '\r', ''),
    OnlineSecurity = REPLACE(OnlineSecurity, '\r', ''),
    OnlineBackup = REPLACE(OnlineBackup, '\r', ''),
    DeviceProtection = REPLACE(DeviceProtection, '\r', ''),
    TechSupport = REPLACE(TechSupport, '\r', ''),
    StreamingTV = REPLACE(StreamingTV, '\r', ''),
    StreamingMovies = REPLACE(StreamingMovies, '\r', ''),
    Contract = REPLACE(Contract, '\r', ''),
    PaperlessBilling = REPLACE(PaperlessBilling, '\r', ''),
    PaymentMethod = REPLACE(PaymentMethod, '\r', '');
