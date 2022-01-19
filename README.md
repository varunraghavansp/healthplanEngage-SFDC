# healthplanEngage-SFDC

HealthplanEngage package for SFDC.

## Development

To work on this project in a scratch org:

1. [Set up CumulusCI](https://cumulusci.readthedocs.io/en/latest/tutorial.html)
2. Authorize Against Dev Org
3. Run `cci flow run dev_org --org dev` to deploy this project to a dev org.
4. Run `cci org browser dev` to open the org in your browser.
5. Run `cci task run load_dataset --org dev` to load sample data into the org.
6. Run the below commands to assign permission set to admin user 

`sfdx force:user:permset:assign -n Product_Configurator -o <<provide your scratch org username>>`

`sfdx force:user:permset:assign -n Sales_Administrator -o <<provide your scratch org username>>`

7. Navigate to Setup -> Actions & Recommendations -> Product Configurator Flow -> Edit and Add In the Default Option.
    
    . Plan Family Setup - Flow
    
    . Plan Component Setup Template - Flow
    
    . Plan Template Setup Template - Flow
    
    . Marketing Plan Template - Flow
    
    Hit Next & Save
7. Do the Same for Account Deployment 
    
    . Add Create Group Quote - Flow
    
    . Create Large Group Quote Request - Flow

8. Sample Load Files For Flows are located in Setup -> Static Resources

To Delete Org After Use `cci org remove dev`
