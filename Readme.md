# Translator App
#### This application build using flutter framework and uses google translate api from rapid api hub to translate the text

### command for running the translator app
 ` flutter run ` 
## Api used in this project 
    
    
# Screenshot
![Image Alt Text](./1st.jpg)              ![Image Alt Text](./2nd.jpg)         ![Image Alt Text](./3rd.jpg)


## there are several bottle neck in appilcation due to less time spent on building its not focused 
## surely will fix in next update. 

# also paste your rapid api key here in apis.dart 


```
final response = await dio.post(
    url.toString(),
    options: Options(
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
'X-RapidAPI-Key': 'your api key here',
        'X-RapidAPI-Host': 'google-translate1.p.rapidapi.com'
      }, 
```
