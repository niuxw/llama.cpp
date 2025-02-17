function! Llm()

  let url = "http://127.0.0.1:8080/completion"

  " Get the content of the current buffer
  let buffer_content = join(getline(1, '$'), "\n")

  " Create the JSON payload
  let json_payload = {"temp":0.72,"top_k":100,"top_p":0.73,"repeat_penalty":1.100000023841858,"n_predict":10,"stream": v:false}
  let json_payload.prompt = buffer_content

  " Define the curl command
  let curl_command = 'curl -k -s -X POST -H "Content-Type: application/json" -d @- ' . url
  let response = system(curl_command, json_encode(json_payload))

  " Extract the content field from the response
  let content = json_decode(response).content

  " Insert the content at the cursor position
  call setline(line('.'), getline('.') . content)
endfunction

command! Llm call Llm()
