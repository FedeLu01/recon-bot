import discord
from discord.ext import commands
from dotenv import load_dotenv
import os
import subprocess

load_dotenv()

token = os.getenv('DISCORD_TOKEN')

intents = discord.Intents.all()
intents.messages = True
intents.members = True

bot = commands.Bot(command_prefix='/', intents=intents)
    
@bot.command()
async def scan(ctx, domain: str):
    if not domain:
        await ctx.send("Proporciona un dominio para escanear.")
        return

    try:
        subprocess.run(["bash", "recon.sh", domain])
    except Exception as e:
        await ctx.send(e)
    
bot.run(token)
        
    