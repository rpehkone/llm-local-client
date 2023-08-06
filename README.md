## llm local client  

<img src="preview.gif" width="1000" height="auto"/>  

```
python -m venv venv  
bash:  
    source venv/bin/activate  
windows:  
    venv\Scripts\activate  
pip install -r requirements.txt  
python run.py  
```

##### Configure config.json  

| Env Variable    | config.json    | examples                                           |
|-----------------|----------------|----------------------------------------------------|
| OPENAI_API_KEY  | openai_key     | sk-...                                             
| OPENAI_API_BASE | openai_api_base | https://api.openai.com <br> https://openai.azure.com <br> http://my-reverse-proxy/  

edit client/data/predefined_prompts.json.  

this is a fork of (various new features) https://github.com/xtekky/chatgpt-clone  
