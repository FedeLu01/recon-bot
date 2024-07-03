import discord
from discord.ext import commands
from dotenv import load_dotenv
import os

load_dotenv()

token = os.getenv('DISCORD_TOKEN')

intents = discord.Intents.all()
intents.messages = True
intents.members = True

bot = commands.Bot(command_prefix='/', intents=intents)

def domain_to_scan(domain):
    os.system(f"DOMAIN={domain} && ./recon.sh")
    
@bot.command()
async def scan(ctx, domain):
    await ctx.send(domain)
    domain_to_scan(domain)
    
bot.run(token)
        
    